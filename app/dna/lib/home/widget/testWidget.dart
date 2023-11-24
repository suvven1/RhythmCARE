import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/GetRhythmController.dart';

heartbeatTestWidget(){
  final RhythmController controller = Get.put(RhythmController());
  return Column(
    children: [
      Row(
        children: [
          Text('심박수 test'),
          TextButton(
              onPressed: () {
                print(++controller.heartRate.value);
              },
              child: Text('+')),
          TextButton(
              onPressed: () {
                print(--controller.heartRate.value);
              },
              child: Text('-')),
        ],
      ),
      Row(
        children: [
          Text('스트레스 test'),
          TextButton(
              onPressed: () {
                print(controller.stressValue.value+=10);
              },
              child: Text('+')),
          TextButton(
              onPressed: () {
                print(controller.stressValue.value-=10);
              },
              child: Text('-')),
        ],
      ),
      Row(
        children: [
          Text('피로도 test'),
          TextButton(
              onPressed: () {
                print(controller.tiredValue.value+=10);
              },
              child: Text('+')),
          TextButton(
              onPressed: () {
                print(controller.tiredValue.value-=10);
              },
              child: Text('-')),
        ],
      ),
    ],
  );
}