// MainActivity.kt (또는 원하는 Kotlin 파일)
package com.example.dna

import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.util.Timer
import kotlin.concurrent.schedule
import kotlin.properties.Delegates

class MainActivity : FlutterActivity() {
    // 채널 명
    val Method_CHANNEL = "rhythm_method"
    val STEPS_CHANNEL = "steps_event"
    val HEART_CHANNEL = "heart_event"

    // 객체화
    val health = HealthConnect();
    val toast = MyToast();

    @RequiresApi(Build.VERSION_CODES.M)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Flutter -> Kotlin -> Flutter 채널
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, Method_CHANNEL)
            .setMethodCallHandler { call, result ->
                MethodChannel(flutterEngine.dartExecutor.binaryMessenger, Method_CHANNEL)
                    .setMethodCallHandler { call, result ->
                        // 여기에 메서드 호출 핸들러 로직을 작성하세요
                        if (call.method.equals("startScan")) {
                            health.scanning(context)
                            Timer().schedule(8000) {
                                result.success(health.scanResultList)
                                Log.d(Debug.TAG,"[Kotlin] Scan Complete")
                            }
                        } else if (call.method.equals("startConnect")) {
                            val adress = call.argument<String>("adress");
                            health.startConnect(adress!!, context)
                            Timer().schedule(8000) {
                                result.success(health.isConnected)
                                health.scanResultList.clear()
                                Log.d(Debug.TAG,"[Kotlin] Connect Complete")
                            }
                        } else if(call.method.equals("disconnect")){
                            result.success(health.disconnect());
                        }else if (call.method.equals("showToast")) {
                            val text = call.argument<String>("text");
                            result.success(toast.showToast(applicationContext, text))
                        } else {
                            result.notImplemented()
                        }
                    }
            }

        // Kotlin -> FLutter 걸음수 채널
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, STEPS_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                private val handler = Handler(Looper.getMainLooper())
                private var eventSink: EventChannel.EventSink? = null
                private var observSteps: Int by Delegates.observable(0) { property, old, new ->
                    var stepMap: MutableMap<String, Int> = mutableMapOf();
                    stepMap["steps"] = new;
                    stepMap["yesterdaySteps"] = health.yesterdaySteps
                    Log.d(Debug.TAG, "[Kotlin] 걸음수 전송 : ${new}걸음")
                    eventSink?.success(stepMap)
                }

                private val runnable: Runnable = object : Runnable {
                    override fun run() {
                        stepUp()
                    }
                }

                fun stepUp() {
                    if (observSteps != health.steps) {
                        observSteps = health.steps
                    }
                    handler.postDelayed(runnable, 1000)
                }

                override fun onListen(arguments: Any?, sink: EventChannel.EventSink) {
                    eventSink = sink
                    handler.post(runnable)
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                    handler.removeCallbacks(runnable)
                }
            })

        // Kotlin -> FLutter 심박수 채널
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, HEART_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                private val handler = Handler(Looper.getMainLooper())
                private var eventSink: EventChannel.EventSink? = null
                private var observHeart: Int by Delegates.observable(0) { property, old, new ->
                    var heartMap: MutableMap<String, Int> = mutableMapOf();
                    heartMap["heart"] = new;
                    Log.d(Debug.TAG, "[Kotlin] 심박수 전송 : ${new}bpm")
                    eventSink?.success(heartMap)
                }

                private val runnable: Runnable = object : Runnable {
                    override fun run() {
                        heartRate()
                    }
                }

                fun heartRate() {
                    if (observHeart != health.heartRate) {
                        observHeart = health.heartRate
                    }
                    handler.postDelayed(runnable, 1000)
                }

                override fun onListen(arguments: Any?, sink: EventChannel.EventSink) {
                    eventSink = sink
                    handler.post(runnable)
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                    handler.removeCallbacks(runnable)
                }
            })
    }
}
