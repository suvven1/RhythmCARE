import 'package:dna/GetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class faceTired extends StatelessWidget {
  const faceTired({super.key});

  @override
  Widget build(BuildContext context) {
    final ReactiveController controller = Get.put(ReactiveController());
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
                  controller.tiredFace,
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
          controller.tiredImage,
          height: 60,
        ),
      ],
    );
  }
}