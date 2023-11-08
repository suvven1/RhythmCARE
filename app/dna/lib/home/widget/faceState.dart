import 'package:dna/GetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class faceState extends StatelessWidget {
  const faceState({super.key, required this.what});

  final String what;
  faceStateText (bool state, bool state2){
    late String result;
    if(what == '스트레스'){
      if(state){
        result = '높은';
      }else{
        result = '낮은';
      }
    }else{
      if(state2){
        result = '높은';
      }else{
        result = '낮은';
      }
    }
    print(state);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final ReactiveController controller = Get.put(ReactiveController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '현재 $what는',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Text(
                  faceStateText(controller.stressHigh.value, controller.tiredHigh.value),
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
        Image.asset(
          'image/heart.gif',
          height: 50,
        ),
      ],
    );
  }
}



// faceState (String what, GetxController controller){
//   late String stateText;
//   if(controller.)
//
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '현재 $what는',
//             style: TextStyle(
//               fontSize: 20,
//             ),
//           ),
//           Row(
//             children: [
//               Text(
//                 '낮은',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.red),
//               ),
//               Text(
//                 ' 상태입니다.',
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       Image.asset(
//         'image/heart.gif',
//         height: 50,
//       ),
//     ],
//   );
// }