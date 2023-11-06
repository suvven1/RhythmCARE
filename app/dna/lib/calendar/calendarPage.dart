import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class calendarPage extends StatefulWidget {
  const calendarPage({super.key});

  @override
  State<calendarPage> createState() => _calendarPageState();
}

class _calendarPageState extends State<calendarPage> {

  DateTime? selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  // 범위 선택 날짜 변수/함수
  DateTime? startDay;
  DateTime? endDay;
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focuseDay){
    setState(() {
      selectedDay = null;
      focusedDay = focuseDay;
      startDay = start;
      endDay = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(2020), // 달력 범위
        lastDay: DateTime.utc(2030), // 달력 범위
        focusedDay: DateTime.now(), // 달력 표기시점

        headerStyle: HeaderStyle(
          headerPadding: EdgeInsets.all(20),
          formatButtonVisible: false, // 포맷 버튼 안 보이게
          titleCentered: true, // 타이틀 센터
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          titleTextFormatter: (date, locale) => DateFormat.yM(locale).format(date),// 타이틀 스타일
        ),
        calendarStyle: CalendarStyle(
          // 오늘 날짜 마커 스타일
          todayDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle
          ),
          // 범위 선택 날짜 마커 스타일
          rangeEndDecoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle
          ),
          // 이번 달 외 숫자 제거
          outsideDaysVisible: false,
          // 선택 날짜 마커 스타일
          selectedDecoration: BoxDecoration(
            color: Color(0xff2e2288),
            shape: BoxShape.circle
          )
        ),

        // 날짜 선택 속성
        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          // 선택된 날짜의 상태를 갱신합니다.
          setState((){
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
          });
        },
        selectedDayPredicate: (DateTime day) {
          // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
          return isSameDay(selectedDay, day);
        },

        // 범위 날짜 선택 속성
        rangeStartDay: startDay,
        rangeEndDay: endDay,
        onRangeSelected: _onRangeSelected,
        rangeSelectionMode: RangeSelectionMode.toggledOn,
      ),
    );
  }
}
