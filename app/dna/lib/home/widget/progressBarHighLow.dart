import 'package:flutter/material.dart';

progressBarHighLow (){
  return Row(
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
  );
}