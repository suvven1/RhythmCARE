//package com.example.dna
//
//import android.bluetooth.le.BluetoothLeScanner
//import android.bluetooth.le.ScanCallback
//import android.bluetooth.le.ScanFilter
//import android.bluetooth.le.ScanResult
//import android.bluetooth.le.ScanSettings
//import android.text.TextUtils
//import android.util.Log
//import com.crrepa.ble.scan.bean.CRPScanDevice
//import com.crrepa.ble.scan.callback.CRPScanCallback
//
//class BluetoothConnectionManager {
//    private val resultApi: ResultApi = TODO();
//    interface ResultApi {
//        fun onBatchScanResults(results: List<ScanResult?>?)
//        fun onScanResult(result: ScanResult?)
//        fun onScanFailed()
//        fun onScanning(device: CRPScanDevice?)
//    }
//
//    private interface ScannerApi {
//        fun startScanning()
//        fun stopScanning()
//    }
//
//    private val scannerApi21: ScannerApi =
//        object : ScannerApi() {
//            var scanner: BluetoothLeScanner? = null
//            var callback: ScanCallback? = null
//            var settings: ScanSettings? = null
//            var filters: ArrayList<*>? = null
//
//            fun startScanning() {
//                if (Debug.DEVICE_INFO.equals(Debug.WELLNESS_CARE)) {
//                    if (scanner == null) {
//                        scanner = mBluetoothAdapter.getBluetoothLeScanner()
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
//                            filters.add(filter)
//                        }
//                        settings = ScanSettings.Builder()
//                            .setScanMode(ScanSettings.SCAN_MODE_LOW_POWER)
//                            .setReportDelay(0)
//                            .build()
//                        callback = object : ScanCallback() {
//                            override fun onScanFailed(errorCode: Int) {
//                                resultApi.onScanFailed()
//                            }
//
//                            override fun onScanResult(callbackType: Int, result: ScanResult) {
//                                if (handler.hasMessages(com.health.lifeband.model.connectivity.BluetoothConnectionManager.EVENT_SCAN_TIMEOUT)) {
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
//            fun stopScanning() {
//                if (scanner != null && mBluetoothAdapter.isEnabled()) {
//                    scanner!!.flushPendingScanResults(callback)
//                    scanner!!.stopScan(callback)
//                }
//            }
//        }
//
//    fun startDeviceScan(resultApi: ResultApi) {
//        this.resultApi = resultApi
//        scannerApi.startScanning()
//        handler.sendEmptyMessageDelayed(
//            com.health.lifeband.model.connectivity.BluetoothConnectionManager.EVENT_SCAN_TIMEOUT,
//            10000
//        )
//    }
//
//}