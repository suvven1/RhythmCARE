import 'package:flutter/material.dart';

class calendarPage extends StatefulWidget {
  const calendarPage({super.key});

  @override
  State<calendarPage> createState() => _calendarPageState();
}

class _calendarPageState extends State<calendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('달력입니다.')),
    );;
  }
}
