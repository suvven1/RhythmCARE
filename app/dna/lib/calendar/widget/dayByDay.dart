import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../GetXCalendar.dart';

class dayByDay extends StatelessWidget {
  const dayByDay({
    Key? key,
    required int this.day,
    required List this.toDay,
    required int this.thirtyOrOne,
  }) : super(key: key);

  final day;
  final toDay;
  final thirtyOrOne;


  @override
  Widget build(BuildContext context) {
    final GetXCalendar controller = Get.put(GetXCalendar());
    return GetX<GetXCalendar>(
      builder: (context) {
        return TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            child: Container(
              color: DateTime.now().day==day ? Colors.green : controller.selectedDay==day ? Colors.blue : Colors.transparent,
              // color: focusDay[index*7+index2-calculateDate(year, month)-1] ? Colors.green : Colors.white,
              height: 60, // 달력의 칸 높이
              child: Column(
                children: [
                  Text(
                    // 달력에 일일 날짜 표시
                    visible(day,thirtyOrOne),
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 15,
                    // 일정 있는 날짜에 지정된 색칠하기
                    color: controller.toDoColor[DateTime(controller.selectedYear.value,controller.selectedMonth.value,day).toString().split(' ')[0]],
                  )
                ],
              ),
            ),
            onPressed: (){
              if (day > 0 && day <= thirtyOrOne){
                print(day);
                controller.selectedDay.value = day;
              }
            }
        );
      }
    );
  }
}


String visible(index, thirtyOrOne) {
  if (index < 1 || index > thirtyOrOne) {
    return '';
  } else {
    return '${index}';
  }
}

String scheduleColorIndex(int year, int month, int day){
  return DateTime(year,month,day).toString().split(' ')[0];
}