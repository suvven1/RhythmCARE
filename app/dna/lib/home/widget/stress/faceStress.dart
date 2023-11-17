import 'package:dna/controller/GetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class faceStress extends StatelessWidget {
  const faceStress({super.key});

  @override
  Widget build(BuildContext context) {
    final ReactiveController controller = Get.put(ReactiveController());
    return GetX<ReactiveController>(
      builder: (_){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '현재 스트레스는',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      controller.stressText,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    Text(
                      ' 상태입니다.',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Image.asset(
              controller.stressImage,
              height: 60,
            ),
          ],
        );
      },
    );
  }
}