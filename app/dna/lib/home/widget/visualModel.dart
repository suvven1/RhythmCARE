import 'package:dna/home/widget/faceState.dart';
import 'package:dna/home/widget/progressWidget.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dna/GetController.dart';

import '../stressPage.dart';
import '../tiredPage.dart';

visualModel (context, String what) {
  return TextButton(
    style: TextButton.styleFrom(
        primary: Colors.black
    ),
    onPressed: (){
      if(what == "스트레스") {
        Get.to(()=>stressPage());
      }else{
        Get.to(()=>tiredPage());
      }
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('현재 $what 지수', style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),),
        SizeBoxH20,
        progressWidget(what: what,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '낮음',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            Text(
              '높음',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizeBoxH30,
        faceState(what: what),
      ],
    ),
  );
}