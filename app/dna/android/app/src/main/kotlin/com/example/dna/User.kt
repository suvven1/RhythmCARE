//package com.health.lifeband.model.data
//
//import android.bluetooth.BluetoothDevice
//import android.content.Context
//import androidx.core.app.NotificationCompat
//import com.crrepa.ble.CRPBleClient
//import com.crrepa.ble.conn.CRPBleConnection
//import com.crrepa.ble.conn.CRPBleDevice
//import com.health.lifeband.R
//import com.health.lifeband.model.api.RestApiManager
//import com.health.lifeband.model.connectivity.BluetoothConnectionManager
//import com.health.lifeband.model.connectivity.dialog.BluetoothGattSingleton
//import com.health.lifeband.model.connectivity.dialog.Callback
//import com.health.lifeband.model.connectivity.dialog.UserdataDataManager
//import com.health.lifeband.model.database.AppDatabase
//import com.health.lifeband.model.database.entity.AbnormalSignal
//import com.health.lifeband.model.database.entity.DepressiveScore
//import com.health.lifeband.model.database.entity.HrMeasurement
//import com.health.lifeband.model.database.entity.MentalScore
//import com.health.lifeband.model.database.entity.PhyScore
//import com.health.lifeband.model.database.entity.ResilienceScore
//import com.health.lifeband.model.database.entity.Spo2Measurement
//import com.health.lifeband.model.database.entity.StressMeasurement
//import com.health.lifeband.model.database.entity.StressScore
//import com.health.lifeband.model.database.entity.WellnessScore
//import com.health.lifeband.utils.Debug
//import okhttp3.ResponseBody
//import retrofit2.Call
//import retrofit2.Response
//import java.util.Calendar
//import javax.security.auth.callback.Callback
//
//class User private constructor() {
//
//    // 런타임 중에 변경되는 정보
//    var isConnectingBtDevice = false
//    var bluetoothUserDataManager: UserdataDataManager? = null
//    var bluetoothConnectionManager: BluetoothConnectionManager
//    private var bluetoothDevice: BluetoothDevice? = null
//    private var mBleClient: CRPBleClient? = null
//    private var mBleDevice: CRPBleDevice? = null
//    var mBleConnection: CRPBleConnection? = null
//    private var context: Context? = null
//    private val uploadDataManager: UploadDataManager
//    var isUserMeasurementInProgress = false
//    var isAutoMeasurementInProgress = false
//    var builder: NotificationCompat.Builder? = null
//    var notificationId = 0
//
//    init {
//        if (Debug.DEVICE_INFO.equals(Debug.WELLNESS_CARE)) {
//            bluetoothUserDataManager = UserdataDataManager()
//        }
//        bluetoothConnectionManager = BluetoothConnectionManager()
//        uploadDataManager = UploadDataManager.getInstance()
//    }
//
//    private object UserHelper {
//        val instance = User()
//            get() = UserHelper.field
//    }
//
//    fun setContext(context: Context?) {
//        this.context = context
//        if (Debug.DEVICE_INFO.equals(Debug.WELLNESS_CARE)) {
//            bluetoothUserDataManager.registerCallBack(context)
//            bluetoothConnectionManager.setRegisterCallBack(context)
//        } else if (Debug.DEVICE_INFO.equals(Debug.LANE2)) {
//            mBleClient = CRPBleClient.create(context!!)
//            bluetoothConnectionManager.setBleClient(mBleClient)
//        }
//        bluetoothConnectionManager.setWakeLock(context)
//    }
//
//    fun startBtScan(resultApi: BluetoothConnectionManager.ResultApi?) {
//        isConnectingBtDevice = false
//        bluetoothConnectionManager.startDeviceScan(resultApi)
//    }
//
//    fun stopBtScan() {
//        bluetoothConnectionManager.stopDeviceScan()
//    }
//
//    fun getBondedDevice(name: String, address: String): BluetoothDevice? {
//        var bluetoothDevice: BluetoothDevice? = null
//        val bluetoothDevices: Set<BluetoothDevice> = bluetoothConnectionManager.getBondedDevice()
//        for (b in bluetoothDevices) {
//            if (b.name == name && b.address == address) {
//                bluetoothDevice = b
//                break
//            }
//        }
//        return bluetoothDevice
//    }
//
//    fun connectGatt(context: Context?, bluetoothDevice: BluetoothDevice) {
//        this.bluetoothDevice = bluetoothDevice
//        bluetoothConnectionManager.setBluetoothDevice(bluetoothDevice)
//        val gatt = bluetoothDevice.connectGatt(
//            context,
//            false,
//            Callback(context),
//            BluetoothDevice.TRANSPORT_LE
//        )
//        BluetoothGattSingleton.setGatt(gatt)
//    }
//
//    fun connectGatt(context: Context?) {
//        mBleDevice = mBleClient!!.getBleDevice(bt_device_mac)
//        mBleConnection = bluetoothConnectionManager.connectGatt(mBleDevice)
//        bluetoothConnectionManager.setRegisterCallBack(context, mBleConnection)
//    }
//
//    fun disconnectGatt() {
//        if (Debug.DEVICE_INFO.equals(Debug.WELLNESS_CARE)) {
//            if (BluetoothGattSingleton.getGatt() != null) {
//                BluetoothGattSingleton.getGatt().disconnect()
//            }
//        } else if (Debug.DEVICE_INFO.equals(Debug.LANE2)) {
//            bluetoothConnectionManager.closeGatt()
//        }
//    }
//}