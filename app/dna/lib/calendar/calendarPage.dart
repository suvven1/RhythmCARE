import 'package:dna/controller/GetXCalendar.dart';
import 'package:dna/calendar/widget/calendarWidget.dart';
import 'package:dna/calendar/widget/schaduleContents.dart';
import 'package:dna/calendar/widget/scheduleDialog.dart';
import 'package:dna/calendar/widget/scheduleTitle.dart';
import 'package:dna/calendar/widget/title.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class calendarPage extends StatefulWidget {
  const calendarPage({super.key});

  @override
  State<calendarPage> createState() => _calendarPageState();
}

class _calendarPageState extends State<calendarPage> {
  late List<List<List<String>>> toDoList;
  late List<List<Color>> toDoColor;

  int thirtyOrOne(int month) {
    List<int> maxDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return maxDay[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final GetXCalendar controller = Get.put(GetXCalendar());
    return GetX<GetXCalendar>(builder: (_) {
      // controller.toDoColor.add(toDoColor);
      return ListView(
        children: [
          // 현재 년/월 표시
          titleWidget(),
          horisonLine,
          // 현재 달력 표시
          calendarWidget(),
          SizeBoxH20,
          horisonLine,
          SizeBoxH10,
          // 현재 선택된 날의 요일 표시
          scheduleTitle(context, controller.selectedDate),
          // 현재 선택된 날의 일정 표시
          schaduleContents(
              context,
              controller.selectedDay.value,
              controller.todayList[controller.selectedDay.value],
              controller.toDoList),
          ElevatedButton(
            child: Text(
              "일정 추가하기",
              style: TextStyle(fontSize: 20),
            ),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
              backgroundColor: MaterialStateProperty.all(Color(0xff2e2288)),
              shape: MaterialStateProperty.all(StadiumBorder()),
            ),
            onPressed: () {
              Get.dialog(scheduleDialog(
                selectedYear: controller.selectedYear.value,
                selectedMonth: controller.selectedMonth.value,
                selectedDay: controller.selectedDay.value,
                toDoList: controller.toDoList,
              ));
            },
          ),
          SizeBoxH30,
        ],
      );
    });
  }
}
