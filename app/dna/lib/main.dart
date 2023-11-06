import 'package:dna/member/findSettingPage.dart';
import 'package:dna/splash.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'mainPage.dart';
import 'member/findPage.dart';
import 'member/join2Page.dart';
import 'member/joinPage.dart';
import 'member/loginPage.dart';

void main() async{
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // member
        '/login' : (_) => loginPage(),
        '/join' : (_) => joinPage(),
        '/join2' : (_) => join2Page(),
        '/find' : (_) => findPage(),
        '/findpw' : (_) => findSettingPage(),
        // main
        '/main' : (_) => mainPage(),
        // calendar
        // hospital
        // home
        // blog
        // mypage
      },
      home: splash(),
    );
  }
}

/*
* 토글버튼 세팅
  borderColor: Color(0xff2e2288), // 큰 박스 선 색
  borderRadius: BorderRadius.all(Radius.circular(50)), // 큰 박스 선 둥글게
  highlightColor: Colors.transparent, // 클릭 시, 동그랗게 퍼지는 색
  fillColor: Color(0xff2e2288), // 선택된 박스 색
  selectedColor: Colors.white, // 선택된 박스 텍스트 색
  color: Colors.grey, // 미 선택된 박스 텍스트 색
  textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),

* 컨테이너 테두리 선
  decoration: BoxDecoration(
    border: Border.all(
      width: 1,
      color: Colors.black
    )
  ),
* 캘린더 라이브러리
  table_calendar
*
*/




