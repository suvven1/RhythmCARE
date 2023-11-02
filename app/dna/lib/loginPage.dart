import 'package:dna/joinPage.dart';
import 'package:flutter/material.dart';

import 'findPage.dart';
import 'homePage.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController idCon = TextEditingController();
  TextEditingController pwCon = TextEditingController();

  // toggle 변수
  bool isGuard = true;
  bool isUser = false;
  late List<bool> isSelected;

  // isSelected 초기화
  @override
  void initState() {
    isSelected = [isGuard, isUser];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Transform.scale(
          scale: 0.82, // 로그인 화면 여백 지정
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset('image/logo.png'),
                  SizedBox(
                    height: 50,
                  ),
                  ToggleButtons(
                    borderColor: Color(0xff2e2288), // 큰 박스 선 색
                    borderRadius: BorderRadius.all(Radius.circular(50)), // 큰 박스 선 둥글게
                    highlightColor: Colors.transparent, // 클릭 시, 동그랗게 퍼지는 색
                    fillColor: Color(0xff2e2288), // 선택된 박스 색
                    selectedColor: Colors.white, // 선택된 박스 텍스트 색
                    color: Colors.grey, // 미 선택된 박스 텍스트 색
                    textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    isSelected: isSelected,
                    onPressed: toggleSelect,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.1,
                        child: const Center(child: Text('보호자 로그인')),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.1,
                        child: const Center(child: Text('사용자 로그인')),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: idCon,
                    decoration: const InputDecoration(
                      labelText: '아이디',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: pwCon,
                    decoration: const InputDecoration(
                      labelText: '비밀번호',
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // FlaltButton 은 화면 위에 떠있는 동그란 버튼
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2e2288)),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Center(child: Text('로그인')),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => homePage()));
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>findPage()));
                          },
                          child: Text('아이디 찾기',
                              style: TextStyle(color: Colors.black))),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>findPage()));
                          },
                          child: Text('비밀번호 찾기',
                              style: TextStyle(color: Colors.black))),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아직 계정이 없으신가요?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => joinPage()));
                    },
                    child: Text('회원가입',
                        style: TextStyle(
                            color: Color(0xff2e2288),
                            fontWeight: FontWeight.bold)),
                  ),
                ],
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
}
