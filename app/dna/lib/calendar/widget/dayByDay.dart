import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/GetXCalendar.dart';

class dayByDay extends StatelessWidget {
  const dayByDay({
    Key? key,
    required int this.day,
    required int this.thirtyOrOne,
  }) : super(key: key);

  final day;
  final thirtyOrOne;

  @override
  Widget build(BuildContext context) {
    final GetXCalendar controller = Get.put(GetXCalendar());
    return day < 1 || day > thirtyOrOne
        ? SizedBox(
            height: 60,
          )
        : GetX<GetXCalendar>(builder: (context) {
            List<Widget> toDoColorContainer() {
              List<Widget> resultList = [];
              for (int i = 0; i < controller.todayList[day-1].length; i++) {
                Color color = Color(int.parse(controller.todayList[day][i][5]));
                resultList.add(Container(
                  height: 10,
                  margin: EdgeInsets.only(bottom: 2),
                  color: color,
                ));
              }
              return resultList;
            }

            return TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DateTime.now().day == day &&
                        DateTime.now().year == controller.selectedYear.value &&
                        DateTime.now().month == controller.selectedMonth.value
                        ? Color(0xffcae6ef)
                        : controller.selectedDay == day &&
                        controller.viewYear.value == controller.selectedYear.value &&
                        controller.viewMonth.value == controller.selectedMonth.value
                        ? Color(0x4e3e9530)
                        : Colors.transparent,
                  ),
                  // 달력의 칸 높이
                  child: Column(
                    children: [
                      Text(
                        // 달력에 일일 날짜 표시
                        '$day',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Column(
                        children: toDoColorContainer(),
                      )
                    ],
                  ),
                ),
                onPressed: () {
                    controller.selectedDay.value = day;
                    controller.viewYear.value = controller.selectedYear.value;
                    controller.viewMonth.value = controller.selectedMonth.value;
                });
          });
  }
}
