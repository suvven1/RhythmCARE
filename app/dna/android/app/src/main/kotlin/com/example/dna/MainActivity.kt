// MainActivity.kt (또는 원하는 Kotlin 파일)
package com.example.dna

import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.util.Timer
import kotlin.concurrent.schedule

class MainActivity : FlutterActivity() {
    val myToast = MyToast();
    val health = HealthConnect();

    private val CHANNEL = "rhythm_channel"

    @RequiresApi(Build.VERSION_CODES.M)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                    .setMethodCallHandler { call, result ->
                        // 여기에 메서드 호출 핸들러 로직을 작성하세요
                        if (call.method.equals("startScan")) {
                            health.connect(context)
                            Timer().schedule(8000) {
                                result.success(health.scanResultStringList)
                                health.scanResultStringList.clear()
                                Log.d(
                                    Debug.TAG,
                                    "scanResultList 가자아아아!!!!!!!!!!!!!!!!"
                                )
                            }
                        } else if (call.method.equals("showToast")) {
                            val text = call.argument<String>("text");
                            result.success(myToast.showToast(applicationContext, text))
                        } else {
                            result.notImplemented()
                        }
                    }
            }
    }

//    private var PERMISSION_REQUEST_CODE = 1
//    private var PERMISSION_REQUEST_CODE_S = 2


//    @RequiresApi (Build.VERSION_CODES.M)
//    private fun requestBlePermissions(arrayOf: Array<Any>, PERMISSION_REQUEST_CODE_S: Int) {
//        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.S){
//            requestBlePermissions(
//                arrayOf(
//                    Manifest.permission.BLUETOOTH_SCAN,
//                    Manifest.permission.BLUETOOTH_CONNECT,
//                    Manifest.permission.ACCESS_FINE_LOCATION
//                    ),
//                this.PERMISSION_REQUEST_CODE_S
//            )
//        }else{
//            requestPermissions(
//                arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
//                PERMISSION_REQUEST_CODE
//            )
//        }
//    }

}
