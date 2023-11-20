//package com.example.dna
//
//import android.bluetooth.BluetoothDevice
//import android.bluetooth.le.ScanResult
//import com.crrepa.ble.scan.bean.CRPScanDevice
//
//class Connection {
//    var isConnectingBtDevice = false
//    private val mBtDevices = ArrayList<BluetoothDevice>()
//    var bluetoothConnectionManager: BluetoothConnectionManager? = null
//
//
//    interface ResultApi {
//        fun onBatchScanResults(results: List<ScanResult?>?)
//        fun onScanResult(result: ScanResult?)
//        fun onScanFailed()
//        fun onScanning(device: CRPScanDevice?)
//    }
//
//    fun startScan(resultApi: ResultApi?) {
//        isConnectingBtDevice = false
//        bluetoothConnectionManager.startDeviceScan(resultApi)
//    }
//}