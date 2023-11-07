
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';


HeaderStyle headerStyle = HeaderStyle(
    headerPadding: EdgeInsets.all(20),
    formatButtonVisible: false,
    // 포맷 버튼 안 보이게
    titleCentered: true,
    // 타이틀 센터
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
    titleTextFormatter: (date, locale) =>
        DateFormat.yM(locale).format(date), // 타이틀 스타일
  );

CalendarStyle calendarStyle = CalendarStyle(
  // 오늘 날짜 마커 스타일
    todayDecoration:
    BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
    // 범위 선택 날짜 마커 스타일
    rangeEndDecoration:
    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
    // 이번 달 외 숫자 제거
    outsideDaysVisible: false,
    // 선택 날짜 마커 스타일
    selectedDecoration: BoxDecoration(
        color: Color(0xff2e2288), shape: BoxShape.circle));