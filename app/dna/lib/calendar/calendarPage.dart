import 'package:dna/calendar/GetXCalendar.dart';
import 'package:dna/calendar/widget/calendarWidget.dart';
import 'package:dna/calendar/widget/schaduleContents.dart';
import 'package:dna/calendar/widget/scheduleTitle.dart';
import 'package:dna/calendar/widget/title.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class calendarPage extends StatelessWidget {
  const calendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GetXCalendar controller = Get.put(GetXCalendar());
    return GetX<GetXCalendar>(
      builder: (_) {
        return ListView(
          children: [
            titleWidget("${DateTime.now().year}.${DateTime.now().month}.", 50, 30),
            horisonLine,
            calendarWidget(controller.selectedDay.value , controller.toDoColor),
            SizeBoxH20,
            horisonLine,
            SizeBoxH10,
            scheduleTitle(context, controller.selectedDate),
            schaduleContents(context, controller.selectedDay.value, controller.toDoList),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  "일정 추가하기",
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(Color(0xff2e2288)),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
            ),
          ],
        );
      }
    );
  }
}
