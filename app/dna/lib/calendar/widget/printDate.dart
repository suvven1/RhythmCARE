import 'package:flutter/material.dart';

List<String> weekDate = ["일", "월", "화", "수", "목", "금", "토"];
List<Color> weekDateColor = [
  Colors.grey,
  Colors.black,
  Colors.black,
  Colors.black,
  Colors.black,
  Colors.black,
  Colors.grey,
];

printDate() {
  return TableRow(
      children: List.generate(
        7,
            (index) => Container(
          height: 20,
          margin: EdgeInsets.all(10),
          child: Text(
            '${weekDate[index]}',
            style: TextStyle(fontSize: 15, color: weekDateColor[index], fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      )
  );
}
