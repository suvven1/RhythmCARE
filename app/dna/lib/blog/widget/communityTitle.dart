import 'package:flutter/material.dart';

communityTitle () {
  TextStyle titleTextStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
  return Container(
    height: 50,
    decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Color(0xff2e2288), width: 4),
            bottom: BorderSide()
        )
    ),
    child: Row(
      children: [
        Expanded(child: Text('글번호', style: titleTextStyle, textAlign: TextAlign.center,), flex: 3,),
        SizedBox(width: 5,),
        Expanded(child: Text('제목', style: titleTextStyle, textAlign: TextAlign.center,), flex: 10,),
        SizedBox(width: 5,),
        Expanded(child: Text('글쓴이', style: titleTextStyle, textAlign: TextAlign.center,), flex: 4,),
        Expanded(child: Text('조회', style: titleTextStyle, textAlign: TextAlign.center,), flex: 3,),
      ],
    ),
  );
}