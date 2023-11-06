
import 'package:flutter/material.dart';

import '../stressPage.dart';
import '../tiredPage.dart';


visualModel (context, String what) {
  return TextButton(
    style: TextButton.styleFrom(
        primary: Colors.black
    ),
    onPressed: (){
      if(what == "스트레스") {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => stressPage()));
      }else{
        Navigator.push(
        context, MaterialPageRoute(builder: (_) => tiredPage()));
      }
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('현재 $what 지수'),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50)),
            ),
            Container(
              margin: EdgeInsets.all(6),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '낮음',
              style: TextStyle(color: Colors.green),
            ),
            Text(
              '높음',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        Row(
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
                      '낮은',
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
        ),
      ],
    ),
  );
}