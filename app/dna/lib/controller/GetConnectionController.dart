import 'dart:async';

import 'package:dna/toastMessage/toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionController extends GetxController {
  static ConnectionController get to => Get.find();
  static const MethodChannel platform = MethodChannel('rhythm_method');

  RxInt steps = 1.obs;
  RxBool isWidgetLoding = true.obs;
  RxString loadingText = "기기 검색중...".obs;
  RxMap<String, String> scanDeviceList = <String, String>{}.obs;
  RxString connectedDeviceName = "연결된 기기 없음".obs;


  void delayConnect(){
    Future.delayed(Duration(seconds: 10), () {
      if (scanDeviceList.isEmpty) {
        steps.value = 3;
      }else{
        Future.delayed(Duration(seconds: 5), () {
          if(loadingText.value.contains("연결중...")) {

          }else{
            steps.value = 3;
          }
        });

      }
    });

  }

  void checkBlue() async {
// 블루투스 활성화 여부 확인
    bool isBluetoothEnabled = await FlutterBlue.instance.isOn;
    if (!isBluetoothEnabled) {
// 블루투스가 비활성화된 경우 활성화 요청
      showToast('블루투스 연결필요');
      steps.value = 4;
    } else {
      steps.value = 2;
    }
  }

  void startScan() async {
    isWidgetLoding.value = true;
    loadingText.value = "기기 검색중...";
    try {
      var scanResult = await platform.invokeMethod("startScan");
      print("[Flutter] 스캔 결과 : ${scanResult}");
      Map<String, String> resultMap = Map<String,String>.from(scanResult);
      scanDeviceList.assignAll(resultMap);
      isWidgetLoding.value = false;
      print(isWidgetLoding.value);
    } on PlatformException catch (e) {
      print("SCAN_ERROR : $e");
    }
  }

  void startConnect(String device) async {
    // 기기 정보 스토리지에 저장
    final deviceDataStorage = await SharedPreferences.getInstance();

    loadingText.value = "${device} 연결중...";
    isWidgetLoding.value = true;
    try {
      var adress = deviceDataStorage.getString("deviceAdress") ?? scanDeviceList[device]!;

      var connectResult = await platform.invokeMethod(
          "startConnect", {'adress': adress});
      isWidgetLoding.value = false;

      if (connectResult) {
        if(scanDeviceList.isNotEmpty){
          showToast("${device}에 연결되었습니다.");
          deviceDataStorage.setString("deviceName", device);
          deviceDataStorage.setString("deviceAdress", scanDeviceList[device]!);
        }

        connectedDeviceName.value = device;
        Get.back();
      } else {
        showToast("연결실패. 다시 시도해주세요.");
        steps.value = 3;
      }
    } on PlatformException catch (e){
      print("CONNECT_ERROR : $e");
    }
  }

  void disconnect() async {
    final deviceDataStorage = await SharedPreferences.getInstance();
    try {
      var disconnectResult = await platform.invokeMethod("disconnect");
      if(disconnectResult){
        deviceDataStorage.remove("deviceAdress");
        deviceDataStorage.remove("deviceName");
        connectedDeviceName.value = "연결된 기기 없음";
        showToast("연결이 해제 되었습니다.");
      }
    } on PlatformException catch (e) {
      print("DISCONNECT_ERROR : $e");
    }
  }

}