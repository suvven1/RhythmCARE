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
  // 심박수
  RhythmController rhythm = Get.put(RhythmController());
  static const heartStream = const EventChannel('heart_event');
  late StreamSubscription<dynamic> _streamSubscription;
  int heartRate = 0;

  @override
  void initState() {
    super.initState();

    _streamSubscription = heartStream.receiveBroadcastStream()
        .listen((heartMap) {
      setState(() {
        if(heartMap["heart"] != null){
          rhythm.heartRate.value = heartMap["heart"];
          // steps = steps;
          print("[Flutter] 심박수 : ${heartMap["heart"]}bpm");
        }else{
          print("여기 아니야!");
        }
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('image/heart.gif'),
        Center(
          heightFactor: 2.3,
          child: Column(
            children: [
                 Text(
                  '${rhythm.heartRate.value}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 65),
                ),
              Text(
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


// heartBeat (int heartBeatNum) {
//   return Stack(
//     children: [
//       Image.asset('image/heart.gif'),
//       Center(
//         heightFactor: 3,
//         child: Column(
//           children: [
//             Text(
//               '$heartBeatNum',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, fontSize: 65),
//             ),
//             Text(
//               'bpm',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, fontSize: 20),
//             )
//           ],
//         ),
//       )
//     ],
//   );
// }