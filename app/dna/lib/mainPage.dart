import 'dart:async';

import 'package:dna/blog/blogPage.dart';
import 'package:dna/calendar/calendarPage.dart';
import 'package:dna/controller/GetRhythmController.dart';
import 'package:dna/home/homePage.dart';
import 'package:dna/hospital/hospitalPage.dart';
import 'package:dna/myBottomNavi.dart';
import 'package:dna/mypage/myPage.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'connection/connect.dart';
import 'controller/GetConnectionController.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  ConnectionController connect = Get.put(ConnectionController());
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    loginToast();
    Future.delayed(Duration.zero, () {
      setState(() {
        checkConnected();

      });
    });
  }

  void checkConnected() async {
    final deviceDataStorage = await SharedPreferences.getInstance();
    var device = deviceDataStorage.getString("deviceName") ?? "STATE_DISCONNECTED";
    if(device == "STATE_DISCONNECTED"){
      Get.dialog(connectDialog());
    }else{
      connect.startConnect(device);
    }

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

  // 로그인 환영 토스트 메세지
  void loginToast() async {
    final loginDataStorage = await SharedPreferences.getInstance();
    final name = loginDataStorage.getString('name') ?? '';
    final nick = loginDataStorage.getString('nick') ?? '';
    showToast('${name}(${nick})님 환영합니다.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
            child: Container(
              color: currentPageIndex == 4 ? Colors.grey[200] : Colors.white,
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05
              ),
              child: pageIndex.elementAt(currentPageIndex),
            )
        ),
      ),
      bottomNavigationBar: myBottomNavi(currentPageIndex, onItemTap),
    );
  }

  // 뒤로가기 두번 누를 시 앱 종료
  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if(currentBackPressTime == null ||
       now.difference(currentBackPressTime!) > Duration(seconds: 2)){
      currentBackPressTime = now;
      final _msg = "뒤로 버튼을 한 번 더 누르시면 종료됩니다.";
      showToast(_msg);
      return Future.value(false);
    }
    final loginDataStorage = await SharedPreferences.getInstance();
    final autoLogin = loginDataStorage.getBool('autoLogin') ?? false;
    if(!autoLogin)loginDataStorage.clear();
    return Future.value(true);
  }

}