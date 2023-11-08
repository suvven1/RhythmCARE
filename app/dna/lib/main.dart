import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'member/loginPage.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: loginPage(),
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

*
*/
