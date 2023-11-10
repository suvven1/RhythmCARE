import 'package:flutter/material.dart';
import 'package:get/get.dart';

schaduleContents (BuildContext context, int selectedDay, Map toDoList){
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
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
        Text(toDoList[selectedDay]==null ? "" : toDoList[selectedDay],
            style: TextStyle(
              fontSize: 22,
            )),
      ],
    ),
  );
}