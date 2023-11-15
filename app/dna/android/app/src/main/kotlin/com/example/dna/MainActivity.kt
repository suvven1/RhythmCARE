// MainActivity.kt (또는 원하는 Kotlin 파일)
package com.example.dna
import android.Manifest
import android.bluetooth.le.ScanResult
import android.content.pm.PackageManager
import android.os.Build
import android.text.TextUtils
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.crrepa.ble.CRPBleClient
import com.crrepa.ble.scan.bean.CRPScanDevice
import com.crrepa.ble.scan.callback.CRPScanCallback
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity(){

    private val CHANNEL = "rhythm_channel"

    @RequiresApi(Build.VERSION_CODES.M)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                // 여기에 메서드 호출 핸들러 로직을 작성하세요
//                if(call.method.equals("getBle")){
//                    if(this.checkSelfPermission(Manifest.permission.BLUETOOTH_SCAN) != PackageManager.PERMISSION_GRANTED){
//                            requestBlePermissions()
//                    }
//                    result.success("sucess")
                if(call.method.equals("getConnect")){
                    result.success(connect())
                }else{
                    result.notImplemented()
                }
            }
    }

    private var PERMISSION_REQUEST_CODE = 1
    private var PERMISSION_REQUEST_CODE_S = 2

    @RequiresApi(Build.VERSION_CODES.M)
    private  fun requestBlePermissions(){
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.S){
            requestPermissions(
                arrayOf(
                    Manifest.permission.BLUETOOTH_SCAN,
                    Manifest.permission.BLUETOOTH_CONNECT,
                    Manifest.permission.ACCESS_FINE_LOCATION
                ),PERMISSION_REQUEST_CODE_S
            )
        } else{
            requestPermissions(
                arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                PERMISSION_REQUEST_CODE
            )
        }
    }

    interface ResultApi {
        fun onBatchScanResults(results: List<ScanResult?>?)
        fun onScanResult(result: ScanResult?)
        fun onScanFailed()
        fun onScanning(device: CRPScanDevice?)
    }

    private val resultApi: ResultApi? = null
    private val Debug = Debug()
    fun connect() : Boolean?{
        val bleClient = CRPBleClient.create(context)
        return bleClient.scanDevice(object : CRPScanCallback {
            override fun onScanning(device: CRPScanDevice) {
                if (TextUtils.isEmpty(device.getDevice().getName())) {
                    return
                }
                if (Debug.LogLevel >= Debug.LEVEL1) Log.d(
                    Debug.TAG,
                    "scanDevice - onScanning" + device.getDevice().getName()
                )
                resultApi?.onScanning(device)
            }

            override fun onScanComplete(results: List<CRPScanDevice>) {
                if (Debug.LogLevel >= Debug.LEVEL1) Log.d(
                    Debug.TAG,
                    "scanDevice - onScanComplete" + results.size
                )
            }
        }, 10000);
    }

    fun scanCallback(): CRPScanCallback? {

        return TODO("Provide the return value")
    }

}
