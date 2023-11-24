import 'package:dna/home/widget/progressBarHighLow.dart';
import 'package:dna/home/widget/progressWidget.dart';
import 'package:dna/home/widget/stress/faceStress.dart';
import 'package:dna/home/widget/tired/faceTired.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../stressPage.dart';
import '../tiredPage.dart';

visualModel (context, String what) {
  if(what == "스트레스"){
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: Colors.black
      ),
      onPressed: (){
          Get.to(()=>stressPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('현재 스트레스 지수', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
          SizeBoxH20,
          progressWidget(what: what,),
          progressBarHighLow(),
          SizeBoxH30,
          faceStress(),
        ],
      ),
    );
  }else{
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: Colors.black
      ),
      onPressed: (){
        Get.to(()=>tiredPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('현재 피로도 지수', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
          SizeBoxH20,
          progressWidget(what: what,),
          progressBarHighLow(),
          SizeBoxH30,
          faceTired(),
        ],
      ),
    );
  }

}