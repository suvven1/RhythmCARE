import 'package:flutter/material.dart';

titleWidget (String title, double iconSize, double fontSize){
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.chevron_left_sharp, size: iconSize,),
        Text(title,style: TextStyle(fontSize: fontSize),),
        Icon(Icons.chevron_right_sharp, size: iconSize,)
      ],
    ),
  );
}