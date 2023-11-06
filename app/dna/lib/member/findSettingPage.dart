import 'package:flutter/material.dart';

import '../widget/sizeBox.dart';
import 'joinPage.dart';
import 'loginPage.dart';

class findSettingPage extends StatefulWidget {
  const findSettingPage({super.key});

  @override
  State<findSettingPage> createState() => _findSettingPageState();
}

class _findSettingPageState extends State<findSettingPage> {

  TextEditingController pwCon = TextEditingController();
  TextEditingController pw2Con = TextEditingController();

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('image/logo.png'),
                  SizeBoxH50,
                  Text('변경할 비밀번호를 입력해주세요'),
                  TextField(
                    controller: pwCon,
                    decoration: const InputDecoration(
                      labelText: '비밀번호',
                    ),
                  ),
                  SizeBoxH10,
                  TextField(
                    controller: pw2Con,
                    decoration: const InputDecoration(
                      labelText: '비밀번호 확인',
                    ),
                  ),
                  SizeBoxH40,
                  // FlaltButton 은 화면 위에 떠있는 동그란 버튼
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2e2288)),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Center(child: Text('로그인 하기')),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>loginPage()));
                    },
                  ),
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
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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
}
