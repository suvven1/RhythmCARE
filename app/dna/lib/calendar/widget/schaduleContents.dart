import 'package:dna/calendar/widget/deleteDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

schaduleContents(
    BuildContext context, int selectedDay, List<List<String>> todayList, List<List<String>> toDoList) {
  List<Widget> toDoText() {
    late List<Widget> toDoTextChild = [];
    for (int i = 0; i < todayList.length; i++) {
      toDoTextChild.add(TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          todayList[i][2],
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        onPressed: () {
          Get.dialog(deleteDialog(todayList: todayList[i], toDoList: toDoList,));
        },
      ));
    }

    return toDoTextChild;
  }

  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Center(
            child: Text(
              '${selectedDay}',
              style: const TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: Color(0xff2e2288),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: toDoText(),
        )
      ],
    ),
  );
}
