import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/GetRhythmController.dart';

class heartBeat extends StatefulWidget {
  const heartBeat({super.key});

  @override
  State<heartBeat> createState() => _heartBeatState();
}

class _heartBeatState extends State<heartBeat> {
  RhythmController rhythm = Get.put(RhythmController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('image/heart.gif'),
        Center(
          heightFactor: 2.3,
          child: Column(
            children: [
                 Obx(()=>
                   Text(
                    '${rhythm.heartRate.value}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 65),
                ),
                 ),
              const Text(
                'bpm',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
        )
      ],
    );
  }
}