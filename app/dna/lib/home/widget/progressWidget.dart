import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/GetRhythmController.dart';

class progressWidget extends StatelessWidget {
  const progressWidget({super.key, required this.what});

  final String what;
  percent (int state, int state2){
    late double result;
    if (what == '스트레스'){
      return result = state/100;
    }else{
      return result = state2/100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final RhythmController controller = Get.put(RhythmController());
    return Stack(
      children: [
        Image.asset('image/stateBar.png'),
        GetX<RhythmController>(
          builder: (_){
            return Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                alignment: FractionalOffset(
                    percent(controller.stressValue.value,
                        controller.tiredValue.value),
                    1),
                child: FractionallySizedBox(
                    child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ))));
          },
        ),
      ],
    );
  }
}
