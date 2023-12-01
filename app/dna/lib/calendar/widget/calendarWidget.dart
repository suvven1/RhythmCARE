import 'package:dna/controller/GetXCalendar.dart';
import 'package:dna/calendar/widget/dayByDay.dart';
import 'package:dna/calendar/widget/printDate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class calendarWidget extends StatefulWidget {
  const calendarWidget({super.key});

  @override
  State<calendarWidget> createState() => _calendarWidgetState();
}

class _calendarWidgetState extends State<calendarWidget> {

  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    final GetXCalendar controller = Get.put(GetXCalendar());
    return GetX<GetXCalendar>(
      builder: (context) {
        return Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            // 요일 출력
            printDate(),
            // 날짜 출력
            ...List.generate(
                fiveOrSix(year, month), // 선택된 달이 몇 주인지? (4~7)
                    (index) => TableRow(
                    children: List.generate(
                        7,
                            (index2) => dayByDay(
                          // 달력 날짜 버튼 위젯
                          day: index * 7 + index2 - calculateDate(controller.selectedYear.value, controller.selectedMonth.value, index, index2),
                          thirtyOrOne: thirtyOrOne(month),))))
          ],
        );
      }
    );
  }
}

// 1일의 요일 번호 [일:0, 월:1, ..., 토:6]
int calculateDate(int year, int month, int index, int index2) {
  List<String> date = ["일", "월", "화", "수", "목", "금", "토"];
  int dateNum = (1 +
              ((((month + 1) * 26) / 10) ~/ 1) +
              (year % 100) +
              ((year % 100) ~/ 4) +
              ((year ~/ 100) ~/ 4) -
              (2 * (year ~/ 100))) %
          7 -
      2;
  return dateNum;
}

int fiveOrSix(int year, int month) {
  List<int> maxDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  if (year % 4 == 0) {
    maxDay[2] = 29;
  }
  int dateNum = (1 +
              ((((month + 1) * 26) / 10) ~/ 1) +
              (year % 100) +
              ((year % 100) ~/ 4) +
              ((year ~/ 100) ~/ 4) -
              (2 * (year ~/ 100))) %
          7 -
      1;
  return (dateNum + maxDay[month - 1] - 1) ~/ 7 + 1;
}

int thirtyOrOne(int month) {
  List<int> maxDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  return maxDay[month - 1];
}
