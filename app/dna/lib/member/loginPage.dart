import 'dart:convert';

import 'package:dna/member/widget/joinWidget.dart';
import 'package:dna/member/widget/textField.dart';
import 'package:dna/member/widget/toggleButton.dart';
import 'package:dna/controller/GetMyPageController.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../mainPage.dart';
import '../widget/sizeBox.dart';
import 'findPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  DateTime? currentBackPressTime;
  MypageController mypageController = Get.put(MypageController());
  TextEditingController idCon = TextEditingController();
  TextEditingController pwCon = TextEditingController();

  // 자동로그인 유무 변수
  bool autoLogin = false;

  // toggle 변수
  bool isGuard = true;
  bool isUser = false;
  late List<bool> isSelected;

  // isSelected 초기화
  @override
  void initState() {
    isSelected = [isGuard, isUser];
    super.initState();
    initialization();
    isLogined();
  }

  void initialization() async {
    await Future.delayed(Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  // 로그인 서버 통신 함수
  void login(bool who, idCon, pwCon) async {
    String loginUser = "mem";

    if (who) {
      loginUser = "mem";
    } else {
      loginUser = "user";
    }

    String url = "http://115.95.222.206:80/user/login";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(
            {'user': loginUser, 'id': idCon.text, 'pw': pwCon.text}));

    // 로그인 결과를 받아와 변수에 저장
    var loginData = jsonDecode(res.body)["loginResult"];
    print(loginData.runtimeType);

    // 로그인 정보 스토리지에 저장
    final loginDataStorage = await SharedPreferences.getInstance();

    setState(() {
      if (loginData.runtimeType != bool) {
        loginDataStorage.setString('id', idCon.text);
        loginDataStorage.setString('name', loginData["name"]);
        loginDataStorage.setString('nick', loginData["nick"]);

        Get.off(() => mainPage());
<<<<<<< HEAD
        showSnackBar(
            context, '${loginData["name"]}(${loginData["nick"]})님 환영합니다.', 2);
      } else if (loginData) {
        showSnackBar(context, '아이디 또는 비밀번호가 일치하지 않습니다.', 2);
      } else {
        showSnackBar(context, '알 수 없는 이유로 오류가 발생하였습니다.', 2);
=======
      }else if(loginData){
        showToast('아이디 또는 비밀번호가 일치하지 않습니다.');
      }else{
        showToast('알 수 없는 이유로 오류가 발생하였습니다.');
>>>>>>> dc9e71ee1412482b7a1548cb70faddd6149e6a9d
      }
    });
  }

  void isLogined() async {
    final loginDataStorage = await SharedPreferences.getInstance();
    final id = loginDataStorage.getString('id') ?? '';
    final name = loginDataStorage.getString('name') ?? '';
    final nick = loginDataStorage.getString('nick') ?? '';
    if (id != '') {
      Get.off(() => mainPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.87,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            child: Image.asset('image/logo.png'),
                            onPressed: () {
                              Get.off(() => mainPage());
                            }),
                        SizeBoxH50,
                        toggleButton(context, isSelected, toggleSelect),
                        SizeBoxH30,
                        textField(idCon, "아이디"),
                        SizeBoxH10,
                        textField(pwCon, "비밀번호"),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              autoLogin = !autoLogin;
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                autoLogin
                                    ? 'image/checkTrue.png'
                                    : 'image/checknull.png',
                                width: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '로그인 유지',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: autoLogin ? FontWeight.bold : null,
                                    color: autoLogin ? Colors.green : Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizeBoxH10,
                        // FlaltButton 은 화면 위에 떠있는 동그란 버튼
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff2e2288)),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            child: Center(child: Text('로그인')),
                          ),
                          onPressed: () async {
                            // 로그인 버튼 클릭 시, 액션을 여기에 넣으면 됨
                            login(isGuard, idCon, pwCon);
                          },
                        ),
                        SizeBoxH20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.to(() => findPage());
                                },
                                child: Text('아이디 찾기',
                                    style: TextStyle(color: Colors.black))),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => findPage());
                                },
                                child: Text('비밀번호 찾기',
                                    style: TextStyle(color: Colors.black))),
                          ],
                        )
                      ],
                    ),
                    joinWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // toggle 함수
  void toggleSelect(value) {
    if (value == 0) {
      isGuard = true;
      isUser = false;
    } else {
      isGuard = false;
      isUser = true;
    }
    setState(() {
      isSelected = [isGuard, isUser];
    });
  }

  // 뒤로가기 두번 누를 시 앱 종료
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      final _msg = "뒤로 버튼을 한 번 더 누르시면 종료됩니다.";
      showToast( _msg);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
