import 'package:dna/calendar/widget/calendarWidget.dart';
import 'package:dna/calendar/widget/title.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';

class calendarPage2 extends StatefulWidget {
  const calendarPage2({super.key});

  @override
  State<calendarPage2> createState() => _calendarPage2State();
}

class _calendarPage2State extends State<calendarPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: [
              // titleName, iconSize, fontSize
              titleWidget("2023.11.", 50, 30),
              horisonLine,
              calendarWidget(),
              horisonLine,
              SizeBoxH10,
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Center(
                        child: Text(
                          '목요일',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2e2288),
                          ),
                        ),
                      ),
                    ),
                    Text('오늘의 일정',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Center(
                        child: Text(
                          '29',
                          style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2e2288),
                          ),
                        ),
                      ),
                    ),
                    Text('00병원 09:00 예약',
                        style: TextStyle(
                          fontSize: 22,
                        )),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text("일정 추가하기",style: TextStyle(fontSize: 20),),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff2e2288)),
                    shape: MaterialStateProperty.all(StadiumBorder()),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
