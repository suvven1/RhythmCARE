// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';

void main() {
  Text('test');
}
// 걸음 수 리스트 >> 35개
List<int> walkNum = List.filled(35, 0);

// Test
void testGrass() {
  walkNum[0] = 10000;
  walkNum[1] = 6000;
}

List<Widget> walkGrass() {
  testGrass();
  int i = 0;
  int j = 0;
  Color grassColor = Colors.grey;
  List<Widget> _container = [];
  List<Widget> _rowContainer = [];
  while (j < 5) {
    i = 0;
    _container = [];
    while (i < 7) {
      if (walkNum[i] > 9999) {
        grassColor = Colors.green;
      } else if (walkNum[i] > 5999) {
        grassColor = Colors.lightGreen;
      } else {
        grassColor = Colors.grey;
      }
      i++;
      _container.add(
        Container(
          margin: EdgeInsets.all(2),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: grassColor,
          ),
        ),
      );
    }
    _rowContainer.add(Row(
        children: _container
    ),);
  }
  return _rowContainer;
}
