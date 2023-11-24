package com.example.dna

import android.Manifest
import android.bluetooth.BluetoothGatt
import android.bluetooth.le.ScanResult
import android.content.Context
import android.content.pm.PackageManager
import android.text.TextUtils
import android.util.Log
import androidx.core.app.ActivityCompat
import com.crrepa.ble.CRPBleClient
import com.crrepa.ble.conn.CRPBleConnection
import com.crrepa.ble.conn.CRPBleDevice
import com.crrepa.ble.conn.bean.CRPHeartRateInfo
import com.crrepa.ble.conn.bean.CRPMovementHeartRateInfo
import com.crrepa.ble.conn.bean.CRPStepInfo
import com.crrepa.ble.conn.listener.CRPBleConnectionStateListener
import com.crrepa.ble.conn.listener.CRPHeartRateChangeListener
import com.crrepa.ble.conn.listener.CRPStepChangeListener
import com.crrepa.ble.conn.type.CRPHeartRateType
import com.crrepa.ble.conn.type.CRPHistoryDynamicRateType
import com.crrepa.ble.conn.type.CRPPastTimeType
import com.crrepa.ble.conn.type.CRPStepsCategoryDateType
import com.crrepa.ble.conn.type.CRPTempTimeType
import com.crrepa.ble.scan.bean.CRPScanDevice
import com.crrepa.ble.scan.callback.CRPScanCallback
import java.util.Timer
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

    var scanResultList : MutableMap<String, String> = mutableMapOf();
    var scanCount : Int = 0;

    lateinit var bleClient: CRPBleClient;
    lateinit var bleConnection: CRPBleConnection;
    var isConnected : Boolean = false;

    // 생체신호
    var steps: Int = 0;
    var heartRate: Int = 0;

     fun scanning(context: Context): CRPBleClient {
         bleClient = CRPBleClient.create(context)
         bleClient.scanDevice(object : CRPScanCallback {
            override fun onScanning(device: CRPScanDevice) {
                if (ActivityCompat.checkSelfPermission(
                        context,
                        Manifest.permission.BLUETOOTH_CONNECT
                    ) != PackageManager.PERMISSION_GRANTED
                ) {
                    Log.d(
                        Debug.TAG,
                        "[Kotlin] PERMISSION ERROR"
                    )
                    return
                }
                if (TextUtils.isEmpty(device.device.name)) {
                    return
                }
                if (Debug.LogLevel >= Debug.LEVEL1) {
                    if(device.device.name == "LANE2") {
                        scanResultList["${device.device.name} ${device.device.address.replace(":", "").takeLast(4)}"] = device.device.address
                        Log.d(
                            Debug.TAG,
                            "[Kotlin] 검색된 기기 : ${device.device.name} ${device.device.address.replace(":", "").takeLast(4)}"
                        )
                        Log.d(
                            Debug.TAG,
                            "[Kotlin] 물리 주소(MAC) : ${device.device.address}"
                        )
                    }
                }
                if(scanCount < 100){
                    resultApi?.onScanning(device)
                    scanCount++
                }else{
                    bleClient.cancelScan();
                }

            }

            override fun onScanComplete(results: List<CRPScanDevice>) {
                if (Debug.LogLevel >= Debug.LEVEL1) {
                    Log.d(
                        Debug.TAG,
                        "[Kotlin] 스캔 완료 : 총 ${results.size}건"
                    )
                }
            }
        }, 10000)
        return bleClient
    }

    fun startConnect(address : String, context: Context) {
        bleClient = CRPBleClient.create(context)
        val bleDevice: CRPBleDevice = bleClient.getBleDevice(address);
        bleConnection= bleDevice.connect();

        var bluetooth_status = 0
        var bluetooth_auto_retry = false


        if (ActivityCompat.checkSelfPermission(
                    context,
                    Manifest.permission.BLUETOOTH_CONNECT
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                Log.d(
                    Debug.TAG,
                    "PERMISSION ERROR"
                )
                return
            }
                Log.d(
                    Debug.TAG,
                    "START CONNECT"
                )

                bleConnection!!.setConnectionStateListener { newState ->
                    bluetooth_status = newState
                    when (newState) {
                        CRPBleConnectionStateListener.STATE_CONNECTED -> {
                            bluetooth_auto_retry = true
                            bleConnection!!.syncTime()

                            Log.d(
                                Debug.TAG,
                                "[Kotlin] 연결성공 : ${bleConnection}"
                            )
                            isConnected = true;
                            setWatch()
                        }

                        CRPBleConnectionStateListener.STATE_CONNECTING -> {
                            Log.d(
                                Debug.TAG,
                                "[Kotlin] 연결 중"
                            )
                        }

                        CRPBleConnectionStateListener.STATE_DISCONNECTED -> {
                            Log.d(
                                Debug.TAG,
                                "[Kotlin] 연결 해제"
                            )
                        }
                    }
                }
    }


    private fun setWatch() {

        // 걸음수
        bleConnection.syncStep();
        bleConnection.queryStepsCategory(CRPStepsCategoryDateType.TODAY_STEPS_CATEGORY);

        // 심박수
        bleConnection.queryTodayHeartRate(CRPHeartRateType.ALL_DAY_HEART_RATE);
        bleConnection.enableTimingMeasureHeartRate(1);

//        bleConnection.queryTimingMeasureTemp(CRPTempTimeType.TODAY);
//        bleConnection?.queryTimingMeasureTemp(CRPTempTimeType.YESTERDAY);
//        bleConnection.startMeasureOnceHeartRate();
//        bleConnection?.syncTime();
//        bleConnection?.queryPastHeartRate();
//        bleConnection?.syncSleep();
//        bleConnection?.syncPastStep(CRPPastTimeType.YESTERDAY_STEPS);
//        bleConnection?.syncPastStep(CRPPastTimeType.DAY_BEFORE_YESTERDAY_STEPS);
//        bleConnection?.syncPastSleep(CRPPastTimeType.YESTERDAY_SLEEP);
//        bleConnection?.syncPastSleep(CRPPastTimeType.DAY_BEFORE_YESTERDAY_SLEEP);
        updateListener()
    }

    fun updateListener() {
        val mHeartRateChangListener : CRPHeartRateChangeListener = object : CRPHeartRateChangeListener {
            override fun onMeasuring(rate: Int) {
                if (Debug.LogLevel >= Debug.LEVEL1){
//                        Log.d(Debug.TAG, "[Kotlin] 심박수 측정중... : ${rate}bpm")
                        heartRate = rate;
                }
            }

            override fun onOnceMeasureComplete(rate: Int) {
                if (Debug.LogLevel >= Debug.LEVEL1){
//                    Log.d(Debug.TAG, "[Kotlin] 심박수 측정완료 : ${rate}bpm")
                }
            }

            override fun onMeasureComplete(type: CRPHistoryDynamicRateType?, info: CRPHeartRateInfo?) {
                if (Debug.LogLevel >= Debug.LEVEL1){
//                    Log.d(Debug.TAG, "[Kotlin] 심박수 측정완료(name) : ${type?.name}")
//                    Log.d(Debug.TAG, "[Kotlin] 심박수 측정완료(heartRateList) : ${info?.heartRateList}")
//                    Log.d(Debug.TAG, "[Kotlin] 심박수 측정완료(timeInterval) : ${info?.timeInterval}")
//                    Log.d(Debug.TAG, "[Kotlin] 심박수 측정완료(heartRateType) : ${info?.heartRateType}")
                }
            }

            override fun on24HourMeasureResult(info: CRPHeartRateInfo?) {
                if (Debug.LogLevel >= Debug.LEVEL1){
//                    Log.d(Debug.TAG, "[Kotlin] 심박수 측정완료(heartRateList) : ${info?.heartRateList}")
//                    Log.d(Debug.TAG, "[Kotlin] 심박수 측정완료(timeInterval) : ${info?.timeInterval}")
//                    Log.d(Debug.TAG, "[Kotlin] 심박수 측정완료(heartRateType) : ${info?.heartRateType}")
//                    Log.d(Debug.TAG, "[Kotlin] 심박수 측정완료(heartRateType) : ${info?.heartRateType}")
                }
            }

            override fun onMovementMeasureResult(p0: MutableList<CRPMovementHeartRateInfo>?) {
                TODO("Not yet implemented")
            }

        }

        val mStepChangeListener: CRPStepChangeListener = object : CRPStepChangeListener {
            override fun onStepChange(info: CRPStepInfo) {
                if (Debug.LogLevel >= Debug.LEVEL1){
//                    Log.d(Debug.TAG,"[Kotlin] 걸음수 증가 : ${info.steps}걸음")
                    steps = info.steps;
                }
            }

            override fun onPastStepChange(timeType: Int, info: CRPStepInfo) {
                if (Debug.LogLevel >= Debug.LEVEL1) Log.d(
                    Debug.TAG,
                    "onPastStepChange : "
                )
            }
        }

        bleConnection.setStepChangeListener(mStepChangeListener);
        bleConnection.setHeartRateChangeListener(mHeartRateChangListener)
    }

    fun disconnect(): Boolean{
        bleConnection.close()
        scanCount = 0
        steps = 0
        heartRate = 0
        scanResultList.clear()
        isConnected = false
        return true;
    }

}
