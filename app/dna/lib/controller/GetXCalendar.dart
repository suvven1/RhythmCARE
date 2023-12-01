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

  RxList<List<String>> toDoList = RxList<List<String>>();



  List<List<List<String>>> reset (List<List<String>> toDoList, int year, int month) {
    int i = 0;
    int j = 1;
    List<List<List<String>>> tempList = List.generate(32, (index) => []);
    DateTime startDate = DateTime.now();
    DateTime lastDate = DateTime.now();
    DateTime currentDate = DateTime.now();
    while(i<toDoList.length){
      startDate = DateTime.parse(toDoList[i]![3]);
      lastDate = DateTime.parse(toDoList[i]![4]);
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

  // 켈린더 정보 초기화
  void setCalenderData(List data){
    for(int i = 0; i < data.length; i++){
      List<String> stringList = List<String>.from(data[i].values.toList());
      stringList[3] = stringList[3].split("T")[0];
      stringList[4] = stringList[4].split("T")[0];
      if(stringList[5] == "#eb6867"){
        stringList[5] = '0xffeb6867';
      }else if(stringList[5] == "#f39a47"){
        stringList[5] = '0xfff39a47';
      }else if(stringList[5] == "#47b794"){
        stringList[5] = '0xff47b794';
      }else if(stringList[5] == "#1eb2d4"){
        stringList[5] = '0xff1eb2d4';
      }else{
        stringList[5] = '0xff762fc1';
      }
      toDoList.add(stringList);
    }

    print("toDoList : ${toDoList}");
  }
}