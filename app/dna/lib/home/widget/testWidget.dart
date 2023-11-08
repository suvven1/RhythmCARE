import 'package:dna/GetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

heartbeatTestWidget(){
  final ReactiveController controller = Get.put(ReactiveController());
  return Column(
    children: [
      Row(
        children: [
          Text('심박수 test'),
          TextButton(
              onPressed: () {
                print(++controller.hearBeatNum.value);
              },
              child: Text('+')),
          TextButton(
              onPressed: () {
                print(--controller.hearBeatNum.value);
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