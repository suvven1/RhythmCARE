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

  int currentPageIndex = 2;

  void onItemTap(index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> pageIndex = <Widget>[
      calendarPage(),
      hospitalPage(),
      homePage(),
      blogPage(),
      myPage(),
    ];

    return Scaffold(
      body: SafeArea(
        child: pageIndex.elementAt(currentPageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff2e2288),
        unselectedItemColor: Colors.grey,
        currentIndex: currentPageIndex,
        onTap: onItemTap,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: '달력'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: '병원'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.heart_broken),
              label: '홈'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.backup_table_outlined),
              label: '블로그'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: '내 정보'
          ),
        ],
      ),
    );
  }
}