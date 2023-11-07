import 'package:dna/calendar/widget/printDate.dart';
import 'package:dna/calendar/widget/printDay.dart';
import 'package:flutter/material.dart';

calendarWidget() {

  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;

  print(calculateDate(year, month, 1));

  return Center(
    child: Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        // 요일 출력
        printDate(),
        // 날짜 출력
        ...List.generate(
            6,
            (index) => printDay(index, calculateDate(year, month, 1)))
      ],
    ),
  );
}

calculateDate (year, month, day){
  List<String> date = ["일","월","화","수","목","금","토"];
  int dateNum = (day+((((month+1)*26)/10)~/1)+(year%100)+((year%100)~/4)+((year~/100)~/4)-(2*(year~/100)))%7-2;
  return dateNum;
}