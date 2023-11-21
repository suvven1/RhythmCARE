import 'package:dna/home/widget/stress/oneDayStressChart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/GetController.dart';

class oneDayStress extends StatefulWidget {
  const oneDayStress({super.key});

  @override
  State<oneDayStress> createState() => _oneDayStressState();
}

class _oneDayStressState extends State<oneDayStress> {

  @override
  Widget build(BuildContext context) {
    final ReactiveController controller = Get.put(ReactiveController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '하루 스트레스',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            GetX<ReactiveController>(
              builder: (_) {
                return Row(
                  children: [
                    Column(
                      children: [
                        Text('현재 스트레스는',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Text(
                              controller.stressText,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('상태입니다.',
                                style: TextStyle(fontWeight: FontWeight.bold))
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
                    )
                  ],
                );
              },
            )
          ],
        ),
        oneDayStressChart(),
      ],
    );
  }
}