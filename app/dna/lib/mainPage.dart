import 'package:dna/blog/blogPage.dart';
import 'package:dna/calendar/calendarPage.dart';
import 'package:dna/home/homePage.dart';
import 'package:dna/hospital/hospitalPage.dart';
import 'package:dna/myBottomNavi.dart';
import 'package:dna/mypage/myPage.dart';
import 'package:flutter/material.dart';

import 'widget/connection/connect.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}


class _mainPageState extends State<mainPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        showPopUp(context);
      });
    });
  }
  // 초기 페이지 2번 인덱스(홈)
  int currentPageIndex = 2;

  // 바텀 네비게이션으로 이동할 페이지 목록
  final List<Widget> pageIndex = <Widget>[
    calendarPage(),
    hospitalPage(),
    homePage(),
    blogPage(),
    myPage(),
  ];

  // 바텀 네비게이션을 클릭할 시, 실행할 메소드
  void onItemTap(index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05
            ),
            child: pageIndex.elementAt(currentPageIndex),
          )
      ),
      bottomNavigationBar: myBottomNavi(currentPageIndex, onItemTap),
    );
  }
}