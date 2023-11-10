import 'package:flutter/material.dart';

class calendarTest extends StatelessWidget {
  const calendarTest({
    Key? key,
    required int this.day,
    required List this.toDay,
    required List this.selectDay,
    required String? this.visible,
    required int? this.thirtyOrOne,
    required Color? this.toDoColor,
  }) : super(key: key);

  final day;
  final toDay;
  final selectDay;
  final visible;
  final thirtyOrOne;
  final toDoColor;

  @override
  Widget build(BuildContext context) {
    print(day);
    print(toDay);
    print(selectDay);
    print(visible);
    print(thirtyOrOne);
    print(toDoColor);
    return Text("1");
  }
}



//   calendarTest(
//           day: index*7+index2-calculateDate(year, month),
//           toDay: toDay,
//           selectDay: selectDay,
//           visible: visible(index*7+index2-calculateDate(year, month), thirtyOrOne(month)),
//           thirtyOrOne: thirtyOrOne(month),
//           toDoColor: toDoColor[index*7+index2-calculateDate(year, month)])
// )))