package com.example.dna

import android.Manifest
import android.annotation.SuppressLint
import android.bluetooth.le.ScanResult
import android.content.Context
import android.content.pm.PackageManager
import android.os.Handler
import android.os.Message
import android.text.TextUtils
import android.util.Log
import androidx.core.app.ActivityCompat
import com.crrepa.ble.CRPBleClient
import com.crrepa.ble.conn.CRPBleConnection
import com.crrepa.ble.conn.CRPBleDevice
import com.crrepa.ble.conn.listener.CRPBleConnectionStateListener
import com.crrepa.ble.conn.type.CRPStepsCategoryDateType
import com.crrepa.ble.conn.type.CRPTempTimeType
import com.crrepa.ble.scan.bean.CRPScanDevice
import com.crrepa.ble.scan.callback.CRPScanCallback
import java.util.Timer
import java.util.concurrent.CompletableFuture
import java.util.concurrent.Future
import kotlin.concurrent.schedule


class HealthConnect {

    private val resultApi: ResultApi? = object : ResultApi {
        override fun onBatchScanResults(results: List<ScanResult?>?) {
            // implement your logic
        }

        override fun onScanResult(result: ScanResult?) {
            // implement your logic
        }

        override fun onScanFailed() {
            // implement your logic
        }

        override fun onScanning(device: CRPScanDevice?) {
            // implement your logic
        }
    }

    interface ResultApi {
        fun onBatchScanResults(results: List<ScanResult?>?)
        fun onScanResult(result: ScanResult?)
        fun onScanFailed()
        fun onScanning(device: CRPScanDevice?)
    }

    var mBleConnection: CRPBleConnection? = null
    private var scanResultList: MutableList<CRPScanDevice> = mutableListOf();
    var scanResultStringList: MutableList<String> = mutableListOf();

    fun connect(context: Context): Boolean {
        val bleClient = CRPBleClient.create(context)
        bleClient.scanDevice(object : CRPScanCallback {
            override fun onScanning(device: CRPScanDevice) {
                if (ActivityCompat.checkSelfPermission(
                        context,
                        Manifest.permission.BLUETOOTH_CONNECT
                    ) != PackageManager.PERMISSION_GRANTED
                ) {
                    return
                }
                if (TextUtils.isEmpty(device.device.name)) {
                    return
                }
                if (Debug.LogLevel >= Debug.LEVEL1) {
                    Log.d(
                        Debug.TAG,
                        "scanDevice - onScanning : " + device.device.name
                    )
                    scanResultList.add(device);
                    scanResultStringList.add(device.device.name)

                }

                if (scanResultStringList.size == 7){
                    bleClient.cancelScan();
                    Log.d(
                        Debug.TAG,
                        "scanDevice : $scanResultStringList"
                    )
                }else{
                    resultApi?.onScanning(device)
                }


            }

            override fun onScanComplete(results: List<CRPScanDevice>) {
                if (Debug.LogLevel >= Debug.LEVEL1) {
                    Log.d(
                        Debug.TAG,
                        "scanDevice - onScanComplete" + results.size
                    )
//                    connect2(bleClient, context)
                }
            }
        }, 10000)

        // 스캔이 완료된 후에 반환될 Future
        return true
    }


    fun connect2(bleClient : CRPBleClient, context : Context){
        for(result in scanResultList){
            if (ActivityCompat.checkSelfPermission(
                    context,
                    Manifest.permission.BLUETOOTH_CONNECT
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                Log.d(
                    Debug.TAG,
                    "PERMISSION ERROR!!!!!!!!"
                )
                return
            }
            if(result.device.name.contains("LANE2")){
                Log.d(
                    Debug.TAG,
                    "start connect"
                )
                Log.d(
                    Debug.TAG,
                    "이놈의 자식 주소 : ${result.device.address}"
                )
                val address : String = result.device.address;
                val bleDevice : CRPBleDevice = bleClient.getBleDevice(address);
                val bleConnection : CRPBleConnection = bleDevice.connect();
                bleConnection.setConnectionStateListener { newState ->
                    Log.d(
                        Debug.TAG,
                        "onConnectionStateChange: $newState"
                    )
                    var state = -1
                    when (newState) {
                        CRPBleConnectionStateListener.STATE_CONNECTED -> {
                            state = 0
                            Log.d(
                                Debug.TAG,
                                "CONNECTED"
                            )
                            testSet()
                        }

                        CRPBleConnectionStateListener.STATE_CONNECTING -> {
                            state = 1
                            Log.d(
                                Debug.TAG,
                                "CONNECTING"
                            )
                        }

                        CRPBleConnectionStateListener.STATE_DISCONNECTED -> {
                            closeGatt()
                            state = 2
                            Log.d(
                                Debug.TAG,
                                "DISCONNECTED"
                            )
                        }
                    }
                }
            }
        }
    }

    private fun closeGatt() {
        Log.d(Debug.TAG, "closeGatt")
        if (mBleConnection != null) {
            mBleConnection!!.close()
        }
    }

    private fun testSet() {
        Log.d(Debug.TAG, "testSet")
        mBleConnection?.queryTimingMeasureTemp(CRPTempTimeType.TODAY);
//        mBleConnection.queryTimingMeasureTemp(CRPTempTimeType.YESTERDAY);

//        mBleConnection.queryTodayHeartRate(CRPHeartRateType.ALL_DAY_HEART_RATE);
//
//        mBleConnection.syncTime();
//        mBleConnection.queryPastHeartRate();
        Log.d(Debug.TAG, "Step Test1 : ${mBleConnection?.syncStep()}");
//        mBleConnection.syncSleep();
//        mBleConnection.syncPastStep(CRPPastTimeType.YESTERDAY_STEPS);
//        mBleConnection.syncPastStep(CRPPastTimeType.DAY_BEFORE_YESTERDAY_STEPS);
//        mBleConnection.syncPastSleep(CRPPastTimeType.YESTERDAY_SLEEP);
//        mBleConnection.syncPastSleep(CRPPastTimeType.DAY_BEFORE_YESTERDAY_SLEEP);
        Log.d(Debug.TAG, "Step Test2 : ${mBleConnection?.queryStepsCategory(CRPStepsCategoryDateType.TODAY_STEPS_CATEGORY)}");



//        sendFindBandMessage();
    }

//    private fun sendFindBandMessage() {
//        handler.sendEmptyMessageDelayed(1, 5000)
//    }
//
//
//    var handler: Handler = object : Handler() {
//        @SuppressLint("HandlerLeak")
//        override fun handleMessage(msg: Message) {
//            super.handleMessage(msg)
//            if (msg.what == 1) {
//                mBleConnection!!.findDevice()
//                sendFindBandMessage()
//            }
//        }
//    }


}
