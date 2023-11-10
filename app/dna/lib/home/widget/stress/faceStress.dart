import 'package:dna/GetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class faceStress extends StatelessWidget {
  const faceStress({super.key});

  // 이거 화면 렌더링이 안 되면 변수는 바뀌는데 아이콘이 렌더링이 안 됨;;

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
                      controller.stressFace,
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