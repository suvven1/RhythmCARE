import 'package:flutter/material.dart';

scheduleTitle(BuildContext context, String selectedDate){
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Center(
            child: Text(
              selectedDate+"요일",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff2e2288),
              ),
            ),
          ),
        ),
        const Text('오늘의 일정',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}