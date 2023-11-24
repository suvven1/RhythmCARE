import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/GetRhythmController.dart';

class faceTired extends StatelessWidget {
  const faceTired({super.key});

  @override
  Widget build(BuildContext context) {
    final RhythmController controller = Get.put(RhythmController());
    return GetX<RhythmController>(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '현재 피로도는',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      controller.tiredText,
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
    );
  }
}