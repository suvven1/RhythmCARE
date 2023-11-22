import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class ConnectionController extends GetxController {
  static ConnectionController get to => Get.find();
  RxBool isWidgetLoding = true.obs;
  RxList<String> scanDeviceList = <String>[].obs;

  static const MethodChannel platform = MethodChannel('rhythm_channel');

  void startScan() async {
    try {
      var result = await platform.invokeMethod("startScan");
      print("플러터측 스캔 결과 : ${result}");
      List<String> resultList = List<String>.from(result);
      scanDeviceList.assignAll(resultList);
      isWidgetLoding.value = false;
      print(isWidgetLoding.value);
    } on PlatformException catch (e) {
      isWidgetLoding.value = true;
    }
  }

  void setDeviceList(String device){
      if(!scanDeviceList.contains(device)){
        scanDeviceList.value.add(device);
        print(scanDeviceList.value);
      }
      isWidgetLoding.value = false;
  }

}