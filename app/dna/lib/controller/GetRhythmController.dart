import 'dart:async';
import 'dart:convert';

import 'package:dna/controller/GetMyPageController.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:dna/url.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

import '../notification/emergency_notification.dart';

class RhythmController extends GetxController {
  static RhythmController get to => Get.find();

  // 걸음수, 심박수 이벤트 채널
  static const stepStream = EventChannel('steps_event');
  static const heartStream = EventChannel('heart_event');
  late StreamSubscription<dynamic> _stepStreamSubscription;
  late StreamSubscription<dynamic> _heartStreamSubscription;

  // 웹소켓
  late IOWebSocketChannel channel;

  // 심박수, 스트레스, 피로도, 걸음수
  RxInt heartRate = 105.obs;
  RxInt OldHeart = 0.obs;
  RxInt steps = 0.obs;
  RxInt stressValue = 0.obs;
  RxInt tiredValue = 0.obs;

  get stressText => stressValue>60 ? '높은':'낮은';
  get stressImage => stressValue>60 ? 'image/heart_bad.png':'image/heart_good.png';

  get tiredText => tiredValue>60 ? '높은':'낮은';
  get tiredImage => tiredValue>60 ? 'image/heart_bad.png':'image/heart_good.png';

  @override
  void onInit() async {
    final userDataStorage = await SharedPreferences.getInstance();
    String ID = userDataStorage.getString("id") ?? "";


    // channel = IOWebSocketChannel.connect('ws://${URL.ip}:90');
    //
    // // 1초마다 웹으로 심박수, 걸음수 보내기
    //
    //   interval(heartRate, (_) {
    //     String device = userDataStorage.getString("deviceName") ?? "";
    //     if(device != ""){
    //       if(OldHeart.value != heartRate.value){
    //         OldHeart.value = heartRate.value;
    //         final data = {"channel": "RhythmCare", "ID": ID, "heartRate" : heartRate.value, "step": steps.value};
    //         channel.sink.add(jsonEncode(data));
    //       }
    //     }
    //   },
    //     time: Duration(seconds: 3),
    //   );


    // 5초마다 심박수 파악후 위험 상황 감지
    interval(heartRate, (_) {
      print("-------------------------------------------------------------");
      if(heartRate.value < 60 || heartRate.value > 100){
        NotificationService().showNotification(["emergency",heartRate.value]);
      }else{
        NotificationService().showNotification(["dailyData",heartRate.value, steps.value]);
      }
    },
      time: Duration(seconds: 5),
    );


    // 1초마다 심박수 확인 후, 콜백함수 실행
    interval(heartRate, (_) {
      final int stress = (((heartRate.value - 80)/80)*100).toInt();
      final int tired = (((heartRate.value - 60)/60)*100).toInt();

      if(stress < 0){
        stressValue.value = 0;
      }else if(stress > 100){
        stressValue.value = 100;
      }else{
        stressValue.value = stress;
      }

      if(tired < 0){
        tiredValue.value = 0;
      }else if(tired > 100){
        tiredValue.value = 100;
      }else{
        tiredValue.value = tired;
      }

    },
      time: Duration(seconds: 10),
    );

    // 1초마다 스트레스 값 확인 후, 콜백함수 실행
    interval(stressValue, (_) {
      if (stressValue > 60) {
        print('스트레스 높음');
      } else {
        print('스트레스 낮음');
      }
    },
      time: Duration(seconds: 10),
    );
    // 1초마다 피로도 값 확인 후, 콜백함수 실행
    interval(tiredValue, (_) {
      if (tiredValue > 60) {
        print('피로도 높음');
      } else {
        print('피로도 낮음');
      }
    },
      time: Duration(seconds: 10),
    );

    setSteps();
    setHeartRate();
  }

  @override
  void dispose() {
    channel.sink.close();
    _stepStreamSubscription.cancel();
    _heartStreamSubscription.cancel();
    super.dispose();
  }

  void setSteps() {
    _stepStreamSubscription = stepStream.receiveBroadcastStream()
        .listen((stepMap) {
        if(stepMap["steps"] != null){
          steps.value = stepMap["steps"];
          print("[Flutter] 걸음수 : ${stepMap["steps"]}걸음");
          print("[Flutter] 어제 걸음수 : ${stepMap["yesterdaySteps"]}걸음");

        }else{
          print("STEP_ERROR");
        }
    });
  }

  void setHeartRate() {
    _heartStreamSubscription = heartStream.receiveBroadcastStream()
        .listen((heartMap) {
      if(heartMap["heart"] != null){
        heartRate.value = heartMap["heart"];
        // steps = steps;
        print("[Flutter] 심박수 : ${heartMap["heart"]}bpm");
      }
    });
  }

}