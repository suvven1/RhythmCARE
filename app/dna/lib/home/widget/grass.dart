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
  RhythmController rhythm = Get.put(RhythmController());

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
                Obx(()=>Text("${rhythm.steps.value}걸음", style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)))
              ],
            ),
            SizeBoxH10,
            const Text('오늘의 걸음 수에 따라 잔디를 채울 수 있어요.', style: TextStyle(color: Colors.grey),),
            const Text('6000보 이상은 연한 잔디,', style: TextStyle(color: Colors.grey),),
            const Text('10000보 이상은 진한 잔디가 채워져요.', style: TextStyle(color: Colors.grey),),
          ],
        ),
        SizeBoxH10,
        grassTable(widget.list, context),
      ],
    );
  }
}
