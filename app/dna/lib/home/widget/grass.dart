import 'dart:async';

import 'package:dna/controller/GetRhythmController.dart';
import 'package:dna/home/widget/grassTable.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class grass extends StatefulWidget {
  grass({Key? key, required this.list}) : super(key: key);

  List<Color> list;

  @override
  State<grass> createState() => _grassState();
}

class _grassState extends State<grass> {
  // 걸음수
  RhythmController rhythm = Get.put(RhythmController());
  static const stepStream = const EventChannel('steps_event');
  late StreamSubscription<dynamic> _streamSubscription;
  int steps = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 걸음수
    _streamSubscription = stepStream.receiveBroadcastStream()
        .listen((stepMap) {
      setState(() {
        if(stepMap["steps"] != null){
          rhythm.steps.value = stepMap["steps"];
          // steps = steps;
          print("[Flutter] 걸음수 : ${stepMap["steps"]}걸음");
        }else{
          print("STEP_ERROR");
        }
      });
    });
  }

  // 걸음수
  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('걸음 수 잔디밭', style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                Text("${rhythm.steps.value}걸음", style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold))
              ],
            ),
            SizeBoxH10,
            const Text('오늘의 걸음 수에 따라 잔디를 채울 수 있어요.', style: TextStyle(color: Colors.grey),),
            const Text('6000보 이상은 연한 잔디,', style: TextStyle(color: Colors.grey),),
            const Text('10000보 이상은 진한 잔디가 채워져요.', style: TextStyle(color: Colors.grey),),
          ],
        ),
        SizeBoxH10,
        grassTable(widget.list),
      ],
    );
  }
}
