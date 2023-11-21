import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class ConnectionController extends GetxController {
  static ConnectionController get to => Get.find();
  RxBool isWidgetLoding = true.obs;
  static const MethodChannel platform = MethodChannel('rhythm_channel');


  void startScan() async {
    try {
      isWidgetLoding.value = await platform.invokeMethod("startScan");
      print(isWidgetLoding.value);
    } on PlatformException catch (e) {
      isWidgetLoding.value = true;
    }

  }

}