import 'dart:convert';

import 'package:dna/controller/GetConnectionController.dart';
import 'package:dna/controller/GetXCalendar.dart';
import 'package:dna/calendar/widget/calendarWidget.dart';
import 'package:dna/calendar/widget/schaduleContents.dart';
import 'package:dna/calendar/widget/scheduleDialog.dart';
import 'package:dna/calendar/widget/scheduleTitle.dart';
import 'package:dna/calendar/widget/title.dart';
import 'package:dna/url.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/GetMyPageController.dart';

class calendarPage extends StatefulWidget {
  const calendarPage({super.key});

  @override
  State<calendarPage> createState() => _calendarPageState();
}

class _calendarPageState extends State<calendarPage> {
  final MypageController mypageController = Get.put(MypageController());
  final GetXCalendar controller = Get.put(GetXCalendar());
  late List<List<List<String>>> toDoList;
  late List<List<Color>> toDoColor;

  int thirtyOrOne(int month) {
    List<int> maxDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return maxDay[month - 1];
  }

  // 캘린더 정보 조회 함수
  void getCalendarData() async {
    final loginDataStorage = await SharedPreferences.getInstance();
    final id = loginDataStorage.getString('id') ?? '';
    controller.toDoList.clear();
    String url = "http://${URL.ip}/calender/getSchedule";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"id": id}));

    // 일정 조회 결과를 받아와 변수에 저장
    var resData = jsonDecode(res.body)["scheduleData"];

    setState(() {
      if (resData != false) {
        controller.setCalenderData(resData);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("this is calender page!");
    getCalendarData();
  }

  @override
  Widget build(BuildContext context) {

    return GetX<GetXCalendar>(builder: (_) {
      // controller.toDoColor.add(toDoColor);
      return RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getCalendarData();
          });
        },
        child: ListView(
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
                controller.toDoList, getCalendarData),
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
                Get.dialog(
                    scheduleDialog(
                  selectedYear: controller.selectedYear.value,
                  selectedMonth: controller.selectedMonth.value,
                  selectedDay: controller.selectedDay.value,
                  toDoList: controller.toDoList,
                ),).then((value){if(value)getCalendarData();});
              },
            ),
            SizeBoxH30,
          ],
        ),
      );
    });
  }
}
