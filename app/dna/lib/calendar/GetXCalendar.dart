import 'package:get/get.dart';

class GetXCalendar extends GetxController{
  static GetXCalendar get to => Get.find();

  // 현재 선택한 날짜의 년월일
  RxInt selectedYear = DateTime.now().year.toInt().obs;
  RxInt selectedMonth = DateTime.now().month.toInt().obs;
  RxInt selectedDay =   DateTime.now().day.toInt().obs;

  // 현재 보이는 화면의 년월
  RxInt viewYear = DateTime.now().year.toInt().obs;
  RxInt viewMonth = DateTime.now().month.toInt().obs;

  String calculateDate (year, month, day){
    List<String> date = ["토","일","월","화","수","목","금",];
    int dateNum = (day+((((month+1)*26)/10)~/1)+(year%100)+((year%100)~/4)+((year~/100)~/4)-(2*(year~/100)))%7;
    return date[dateNum];
  }

  int thirtyOrOne(int month) {
    List<int> maxDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return maxDay[month - 1];
  }

  RxList<List<String>> toDoList = [
    ['병원 예약', '2023-11-09', '2023-11-12', '0xffeb6867'],
    ['하하하하하핳', '2023-11-15', '2023-11-16', '0xffeb6867'],
    ['어 왜 안 되지?', '2023-11-16', '2023-11-17', '0xff47b794'],
  ].obs;



  List<List<List<String>>> reset (List<List<String>> toDoList, int year, int month) {
    int i = 0;
    int j = 1;
    List<List<List<String>>> tempList = List.generate(31, (index) => []);
    DateTime startDate = DateTime.now();
    DateTime lastDate = DateTime.now();
    DateTime currentDate = DateTime.now();
    while(i<toDoList.length){
      startDate = DateTime.parse(toDoList[i]![1]);
      lastDate = DateTime.parse(toDoList[i]![2]);
      while(j<thirtyOrOne(month)+1){
        currentDate = DateTime(year, month, j);
        if(!startDate.isAfter(currentDate) && !lastDate.isBefore(currentDate)){
          tempList[j].add(toDoList[i]!);
        }
        j++;
      }
      j = 1;
      i++;
    }
    return tempList;
  }

  get todayList => reset(toDoList, selectedYear.value, selectedMonth.value);

  // get selectedDate => '목요일';
  get selectedDate => calculateDate(selectedYear.value, selectedMonth.value, selectedDay.value);

  // void selectedTrue(int select){
  //   selectedDay = select.obs;
  // }
}