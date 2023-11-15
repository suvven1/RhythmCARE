//package com.example.dna
//
//import android.bluetooth.BluetoothAdapter
//import android.bluetooth.BluetoothDevice
//import android.bluetooth.le.BluetoothLeScanner
//import android.bluetooth.le.ScanCallback
//import android.bluetooth.le.ScanFilter
//import android.bluetooth.le.ScanResult
//import android.bluetooth.le.ScanSettings
//import android.content.BroadcastReceiver
//import android.content.Context
//import android.os.Build
//import android.os.Handler
//import android.os.PowerManager
//import android.text.TextUtils
//import android.util.Log
//import androidx.annotation.RequiresApi
//import com.crrepa.ble.CRPBleClient
//import com.crrepa.ble.conn.CRPBleConnection
//import com.crrepa.ble.scan.bean.CRPScanDevice
//import com.crrepa.ble.scan.callback.CRPScanCallback
//
//class ConnectionManager {
//
//    private val scannedDevices: java.util.HashMap<String, BluetoothDevice>? = null
//    private val bluetoothDeviceList: java.util.ArrayList<BluetoothDevice>? = null
//    private val mBluetoothAdapter: BluetoothAdapter? = null
//    private val scannerApi: ScannerApi? = null
//    var bluetoothDevice: BluetoothDevice? = null
//    private val wakeLock: PowerManager.WakeLock? = null
//    val Debug = Debug()
//    private interface ScannerApi {
//        fun startScanning()
//        fun stopScanning()
//    }
//
//    private val resultApi: ResultApi? = null
//    var bluetooth_status = 0
//    var bluetooth_auto_retry = false
//    private val connectionStateReceiver: BroadcastReceiver? = null
//
//    var mBleConnection: CRPBleConnection? = null
//    var mBleClient: CRPBleClient? = null
//    private val SCAN_PERIOD = 10 * 1000
//
//    interface ResultApi {
//
//        private val scannedDevices: HashMap<String, BluetoothDevice>? = null
//        private val bluetoothDeviceList: java.util.ArrayList<BluetoothDevice>? = null
//        private val mBluetoothAdapter: BluetoothAdapter? = null
//        private val scannerApi: ScannerApi? = null
//        var bluetoothDevice: BluetoothDevice? = null
//        private val wakeLock: PowerManager.WakeLock? = null
//
//        private interface ScannerApi {
//            fun startScanning()
//            fun stopScanning()
//        }
//
//        fun onBatchScanResults(results: List<ScanResult?>?)
//        fun onScanResult(result: ScanResult?)
//        fun onScanFailed()
//        fun onScanning(device: CRPScanDevice?)
//    }
//
//    private val scannerApi21: com.example.dna.ConnectionManager.ScannerApi =
//        object : com.example.dna.ConnectionManager.ScannerApi() {
//            var scanner: BluetoothLeScanner? = null
//            var callback: ScanCallback? = null
//            var settings: ScanSettings? = null
//            var filters: ArrayList<*>? = null
//            @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
//            override fun startScanning() {
//                if (Debug.DEVICE_INFO.equals(Debug.WELLNESS_CARE)) {
//                    if (scanner == null) {
//                        scanner = mBluetoothAdapter?.getBluetoothLeScanner()
//                        if (scanner == null) {
//                            return
//                        }
//                        filters = ArrayList<Any>()
//                        var filterlist = arrayOf<String?>()
//                        if (Debug.DEVICE_INFO.equals(Debug.WELLNESS_CARE)) {
//                            filterlist = arrayOf("WellnessCare")
//                        } else if (Debug.DEVICE_INFO.equals(Debug.LANE2)) {
//                            filterlist = arrayOf("LANE2")
//                        }
//                        for (i in filterlist.indices) {
//                            val filter = ScanFilter.Builder().setDeviceName(filterlist[i]).build()
//                            (filters as ArrayList<Any>).add(filter)
//                        }
//                        settings = ScanSettings.Builder()
//                            .setScanMode(ScanSettings.SCAN_MODE_LOW_POWER)
//                            .setReportDelay(0)
//                            .build()
//                        callback = object : ScanCallback() {
//                            override fun onScanFailed(errorCode: Int) {
//                                resultApi?.onScanFailed()
//                            }
//
//                            override fun onScanResult(callbackType: Int, result: ScanResult) {
//                                if (handler.hasMessages(comConnectionManager.EVENT_SCAN_TIMEOUT)) {
//                                    handler.removeMessages(com.health.lifeband.model.connectivity.BluetoothConnectionManager.EVENT_SCAN_TIMEOUT)
//                                }
//                                resultApi.onScanResult(result)
//                            }
//
//                            override fun onBatchScanResults(results: List<ScanResult>) {
//                                if (handler.hasMessages(com.health.lifeband.model.connectivity.BluetoothConnectionManager.EVENT_SCAN_TIMEOUT)) {
//                                    handler.removeMessages(com.health.lifeband.model.connectivity.BluetoothConnectionManager.EVENT_SCAN_TIMEOUT)
//                                }
//                                resultApi.onBatchScanResults(results)
//                            }
//                        }
//                    }
//                    scanner.startScan(filters, settings, callback)
//                } else if (Debug.DEVICE_INFO.equals(Debug.LANE2)) {
//                    val success: Boolean = mBleClient.scanDevice(
//                        object : CRPScanCallback {
//                            override fun onScanning(device: CRPScanDevice) {
//                                if (TextUtils.isEmpty(device.device.name)) {
//                                    return
//                                }
//                                if (Debug.LogLevel >= Debug.LEVEL1) Log.d(
//                                    Debug.TAG,
//                                    "scanDevice - onScanning" + device.device.name
//                                )
//                                resultApi.onScanning(device)
//                            }
//
//                            override fun onScanComplete(results: List<CRPScanDevice>) {
//                                if (Debug.LogLevel >= Debug.LEVEL1) Log.d(
//                                    Debug.TAG,
//                                    "scanDevice - onScanComplete" + results.size
//                                )
//                            }
//                        },
//                        com.health.lifeband.model.connectivity.BluetoothConnectionManager.SCAN_PERIOD.toLong()
//                    )
//                }
//            }
//
//            override fun stopScanning() {
//                if (scanner != null && mBluetoothAdapter.isEnabled()) {
//                    scanner!!.flushPendingScanResults(callback)
//                    scanner!!.stopScan(callback)
//                }
//            }
//        }
//
//    val DELAY_TIME = 10000
//    val EVENT_RETRY_BT_DELAYED = 1
//    val EVENT_SCAN_TIMEOUT = 2
//    private val handler = Handler { message ->
//        when (message.what) {
//            EVENT_RETRY_BT_DELAYED -> {
//                if (bluetooth_auto_retry == true) {
//                    val context = message.obj as Context
//                    if (Debug.DEVICE_INFO.equals(Debug.WELLNESS_CARE)) {
//                        BluetoothGattSingleton.getGatt().disconnect()
//                    } else if (Debug.DEVICE_INFO.equals(Debug.LANE2)) {
//                        closeGatt()
//                    }
//                    startReconnectEvent(context)
//                }
//            }
//
//            EVENT_SCAN_TIMEOUT -> {
//                resultApi!!.onScanFailed()
//            }
//        }
//        false
//    }
//
//}