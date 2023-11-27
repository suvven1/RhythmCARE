import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'member/loginPage.dart';
import 'package:get/get.dart';

import 'notification/emergency_notification.dart';


void main() async {
  // 앱 실행 전에 NotificationService 인스턴스 생성
  final notificationService = NotificationService();
  // Flutter 엔진 초기화
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // 로컬 푸시 알림 초기화
  await notificationService.init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginPage(),
    );
  }

}
