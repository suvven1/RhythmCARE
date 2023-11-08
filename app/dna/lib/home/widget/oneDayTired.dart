import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../GetController.dart';

class oneDayTired extends StatelessWidget {
  const oneDayTired({super.key});

  faceStateText(bool state){
    if(state){
      return '높은';
    }else{
      return '낮은';
    }
  }

  faceStateImage(bool state){
    if(state){
      return 'image/heart_bad.png';
    }else{
      return 'image/heart_good.png';
    }
  }

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
                      children: [
                        Text('현재 피로도는',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Text(
                              faceStateText(controller.tiredHigh.value),
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
                      faceStateImage(controller.tiredHigh.value),
                      height: 60,
                    )
                  ],
                );
              },
            )
          ],
        ),
        Image.asset('image/visualModel_Day.png'),
      ],
    );
  }
}
