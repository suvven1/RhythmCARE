import 'package:dna/blog/blogPage.dart';
import 'package:dna/calendar/calendarPage.dart';
import 'package:dna/home/homePage.dart';
import 'package:dna/hospital/hospitalPage.dart';
import 'package:dna/mypage/myPage.dart';
import 'package:flutter/cupertino.dart';

enum BottomNaviItem {
  calendar,
  hospital,
  home,
  blog,
  myPage,
}

Map<BottomNaviItem, Widget> openScreen = {
  BottomNaviItem.calendar: const calendarPage(),
  BottomNaviItem.hospital: const hospitalPage(),
  BottomNaviItem.home: const homePage(),
  BottomNaviItem.blog: const blogPage(),
  BottomNaviItem.myPage: const myPage(),
};
