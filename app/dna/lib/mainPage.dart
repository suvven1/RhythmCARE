import 'dart:async';
import 'dart:convert';
import 'package:dna/widget/enums/bottomNavItem.dart';

import 'package:dna/blog/blogPage.dart';
import 'package:dna/calendar/calendarPage.dart';
import 'package:dna/controller/GetNoticeController.dart';
import 'package:dna/controller/GetRhythmController.dart';
import 'package:dna/home/homePage.dart';
import 'package:dna/hospital/hospitalPage.dart';
import 'package:dna/myBottomNavi.dart';
import 'package:dna/mypage/myPage.dart';
import 'package:dna/widget/shakeDialog.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:dna/url.dart';
import 'package:dna/widget/shakeDetector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'connection/connect.dart';
import 'controller/GetConnectionController.dart';
import 'notification/emergency_notification.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  ConnectionController connect = Get.put(ConnectionController());
  NoticeController notice = Get.put(NoticeController());
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    loginToast();
    attend();
    Future.delayed(Duration.zero, () {
      setState(() {
        checkConnected();
        notice.requestNotificationPermissions(context);
      });
    });
    // 흔들기 시작
    detector.startListening();
  }

  void checkConnected() async {
    final deviceDataStorage = await SharedPreferences.getInstance();
    var device =
        deviceDataStorage.getString("deviceName") ?? "STATE_DISCONNECTED";
    if (device == "STATE_DISCONNECTED") {
      Get.dialog(connectDialog());
    } else {
      connect.startConnect(device);
    }
  }

  // 초기 페이지 2번 인덱스(홈)
  int currentPageIndex = 2;

  // 바텀 네비게이션으로 이동할 페이지 목록
  final Map<BottomNaviItem, GlobalKey<NavigatorState>> navigatorKeys = {
    BottomNaviItem.calendar: GlobalKey<NavigatorState>(),
    BottomNaviItem.hospital: GlobalKey<NavigatorState>(),
    BottomNaviItem.home: GlobalKey<NavigatorState>(),
    BottomNaviItem.blog: GlobalKey<NavigatorState>(),
    BottomNaviItem.myPage: GlobalKey<NavigatorState>(),
  };

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

  // 출석 체크
  void attend() async {
    // 현재 날짜 및 시간 받아오기
    DateTime now = DateTime.now();

    // 현재 날짜 출력 (년-월-일)
    String attendDate =
        "${now.year}-${_addZero(now.month)}-${_addZero(now.day)}";
    print('출석 날짜: $attendDate');

    // 출석 체크 로직
    final loginDataStorage = await SharedPreferences.getInstance();
    final id = loginDataStorage.getString('id') ?? '';

    String url = "http://${URL.ip}/attend/dateCal";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'id': id, 'today': attendDate}));

    // 통신 결과를 받아와 변수에 저장
    var attendResult = jsonDecode(res.body)["attendResult"];
    setState(() {
      if (attendResult.runtimeType != bool) {
        showToast(
            '누적 출석일수 : ${attendResult["total"]}일\n연속 출석일수 : ${attendResult["continue"]}일');
      }
    });
  }

  String _addZero(int number) {
    // 한 자리 수일 경우 앞에 0 추가
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                _buildOffstageNavigator(BottomNaviItem.calendar),
                _buildOffstageNavigator(BottomNaviItem.hospital),
                _buildOffstageNavigator(BottomNaviItem.home),
                _buildOffstageNavigator(BottomNaviItem.blog),
                _buildOffstageNavigator(BottomNaviItem.myPage),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: myBottomNavi(currentPageIndex, onItemTap),
    );
  }

  // 뒤로가기 두번 누를 시 앱 종료
  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      final _msg = "뒤로 버튼을 한 번 더 누르시면 종료됩니다.";
      showToast(_msg);
      return Future.value(false);
    }
    final loginDataStorage = await SharedPreferences.getInstance();
    final autoLogin = loginDataStorage.getBool('autoLogin') ?? false;
    if (!autoLogin) loginDataStorage.clear();
    return Future.value(true);
  }

  Widget _buildOffstageNavigator(BottomNaviItem item) {
    return Offstage(
      offstage: currentPageIndex != item.index,
      child: Navigator(
        key: navigatorKeys[currentPageIndex],
        initialRoute: '/',
        onGenerateRoute: (settings) {
          print(settings);
          return MaterialPageRoute(
            builder: (context) {
              return openScreen[item]!;
            },
          );
        },
      ),
    );
  }
}
