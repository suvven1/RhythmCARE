import 'package:dna/home/widget/tired/oneDayTiredChart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/GetController.dart';

class oneDayTired extends StatelessWidget {
  const oneDayTired({super.key});

  @override
  Widget build(BuildContext context) {
    final ReactiveController controller = Get.put(ReactiveController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '하루 피로도',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            GetX<ReactiveController>(
              builder: (_){
                return Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('현재 피로도는',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Text(
                              controller.tiredText,
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
                      controller.tiredImage,
                      height: 60,
                    )
                  ],
                );
              },
            )
          ],
        ),
        oneDayTiredChart(),
      ],
    );
  }
}
