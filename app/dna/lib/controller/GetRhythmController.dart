import 'dart:async';

import 'package:dna/toastMessage/toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class RhythmController extends GetxController {
  static RhythmController get to => Get.find();


  // 심박수, 스트레스, 피로도, 걸음수
  RxInt heartRate = 0.obs;
  RxInt steps = 0.obs;
  RxInt stressValue = 0.obs;
  RxInt tiredValue = 0.obs;

  get stressText => stressValue>60 ? '높은':'낮은';
  get stressImage => stressValue>60 ? 'image/heart_bad.png':'image/heart_good.png';

  get tiredText => tiredValue>60 ? '높은':'낮은';
  get tiredImage => tiredValue>60 ? 'image/heart_bad.png':'image/heart_good.png';

  @override
  void onInit() {
    // 1초마다 심박수 확인 후, 콜백함수 실행
    interval(heartRate, (_) {
      if(heartRate.value == 0 && steps.value == 0){
        stressValue.value = 0;
        tiredValue.value = 0;
      }else if(heartRate.value > 85){
        if(stressValue.value == 100 && tiredValue.value == 0){
        }else if(stressValue.value == 100 && tiredValue.value > 0){
          tiredValue.value = tiredValue.value - 1;
        }else if(stressValue.value < 100 && tiredValue.value == 0){
          stressValue.value = stressValue.value + 1;
        }else{
          stressValue.value = stressValue.value + 1;
          tiredValue.value = tiredValue.value - 1;
        }
      }else{
        if(tiredValue.value == 100 && stressValue.value == 0){
        }else if(tiredValue.value == 100 && stressValue.value > 0){
          stressValue.value = stressValue.value - 1;
        }else if(tiredValue.value < 100 && stressValue.value == 0){
          tiredValue.value = tiredValue.value + 1;
        }else{
          stressValue.value = stressValue.value - 1;
          tiredValue.value = tiredValue.value + 1;
        }
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
  }

}