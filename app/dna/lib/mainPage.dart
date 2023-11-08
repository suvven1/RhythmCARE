import 'package:dna/blog/blogPage.dart';
import 'package:dna/calendar/calendarPage2.dart';
import 'package:dna/home/homePage.dart';
import 'package:dna/hospital/hospitalPage.dart';
import 'package:dna/mypage/myPage.dart';
import 'package:flutter/material.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  // 초기 페이지 2번 인덱스(홈)
  int currentPageIndex = 2;

  // 바텀 네비게이션으로 이동할 페이지 목록
  final List<Widget> pageIndex = <Widget>[
    calendarPage2(),
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff2e2288),
        unselectedItemColor: Colors.grey,
        currentIndex: currentPageIndex,
        onTap: onItemTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: '달력'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital), label: '병원'),
          BottomNavigationBarItem(icon: Icon(Icons.heart_broken), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.backup_table_outlined), label: '블로그'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: '내 정보'),
        ],
      ),
      // ), willpop 사용 시, 괄호
    );
  }
}
