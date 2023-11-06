import 'package:flutter/material.dart';

printDay(int propsIndex, int minusDay) {
  return TableRow(
    children: List.generate(
      7,
          (index) => Container(
        height: 50,
        margin: EdgeInsets.all(10),
        child: Text(
          '${index + propsIndex * 7 - minusDay}',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    )
  );
}