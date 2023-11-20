// MainActivity.kt (또는 원하는 Kotlin 파일)
package com.example.dna
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.crrepa.ble.scan.callback.CRPScanCallback
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(){
    val myToast = MyToast();

    private val CHANNEL = "rhythm_channel"
    @RequiresApi(Build.VERSION_CODES.M)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                // 여기에 메서드 호출 핸들러 로직을 작성하세요
                if(call.method.equals("startScan")){
                    result.success(connect())
                }else if(call.method.equals("showToast")){
                    val text = call.argument<String>("text");
                    result.success(myToast.showToast(applicationContext, text))
                }else{
                    result.notImplemented()
                }
            }
    }


    fun connect() : Boolean?{
        return false;
//        val bleClient = CRPBleClient.create(context)
//        return bleClient.scanDevice(object : CRPScanCallback {
//            override fun onScanning(device: CRPScanDevice) {
//                if (TextUtils.isEmpty(device.getDevice().getName())) {
//                    return
//                }
//                if (Debug.LogLevel >= Debug.LEVEL1) Log.d(
//                    Debug.TAG,
//                    "scanDevice - onScanning" + device.getDevice().getName()
//                )
//                resultApi?.onScanning(device)
//            }
//
//            override fun onScanComplete(results: List<CRPScanDevice>) {
//                if (Debug.LogLevel >= Debug.LEVEL1) Log.d(
//                    Debug.TAG,
//                    "scanDevice - onScanComplete" + results.size
//                )
//            }
//        }, 10000);
    }

    fun scanCallback(): CRPScanCallback? {

        return TODO("Provide the return value")
    }

}
