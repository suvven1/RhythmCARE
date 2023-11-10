import 'dart:ui';

import 'package:get/get.dart';

class GetXCalendar extends GetxController{
  static GetXCalendar get to => Get.find();

  RxInt selectedYear = DateTime.now().year.toInt().obs;
  RxInt selectedMonth = DateTime.now().month.toInt().obs;
  RxInt selectedDay =   DateTime.now().day.toInt().obs;

  String calculateDate (year, month, day){
    List<String> date = ["토","일","월","화","수","목","금",];
    int dateNum = (day+((((month+1)*26)/10)~/1)+(year%100)+((year%100)~/4)+((year~/100)~/4)-(2*(year~/100)))%7;
    return date[dateNum];
  }

  int thirtyOrOne(int month) {
    List<int> maxDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return maxDay[month - 1];
  }

  RxMap<int, String> toDoList = {
    9:'병원 예약',
    15:'하하하하하핳',
    16:'어 왜 안 되지?',
  }.obs;

  RxMap<int, Color> toDoColor = {
    9:Color(0xff2e2288),
    15:Color(0xff2e2288),
    16:Color(0xff2e2288),
  }.obs;

  // get selectedDate => '목요일';
  get selectedDate => calculateDate(selectedYear.value, selectedMonth.value, selectedDay.value);

  // void selectedTrue(int select){
  //   selectedDay = select.obs;
  // }
}