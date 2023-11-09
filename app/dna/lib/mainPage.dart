import 'package:dna/blog/blogPage.dart';
import 'package:dna/calendar/calendarPage.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentPageIndex,
        onTap: onItemTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // 선택된 탭 인덱스(selectedIndex) 값에 따라
            // 0이면 색칠된 아이콘, 아니라면 회색 아이콘 (3항 연산자)
              icon: currentPageIndex ==
                  0 // 선택된 탭은 채워진 아이콘, 나머지는 line 아이콘
                  ? Image.asset(
                'image/icon1-1.png',
              )
                  : Image.asset(
                'image/logo.png',
              ),
              label: "달력"),
          BottomNavigationBarItem(
              icon: currentPageIndex == 1
                  ? Image.asset(
                'image/navigationBarIcon/icon2-1.png',
              )
                  : Image.asset(
                'image/navigationBarIcon/icon2-2.png',
              ),
              label: "병원"),
          BottomNavigationBarItem(
              icon: currentPageIndex == 2
                  ? Image.asset(
                'image/navigationBarIcon/icon3-1.png',
              )
                  : Image.asset(
                'image/navigationBarIcon/icon3-2.png',
              ),
              label: "홈"),
          BottomNavigationBarItem(
              icon: currentPageIndex == 3
                  ? Image.asset(
                'image/navigationBarIcon/icon4-1.png',
              )
                  : Image.asset(
                'image/navigationBarIcon/icon4-2.png',
              ),
              label: "블로그"),
          BottomNavigationBarItem(
              icon: currentPageIndex == 4
                  ? Image.asset(
                'image/navigationBarIcon/icon5-1.png',
              )
                  : Image.asset(
                'image/navigationBarIcon/icon5-2.png',
              ),
              label: "내 정보"),
        ],
      ),
      // ), willpop 사용 시, 괄호
    );
  }
}