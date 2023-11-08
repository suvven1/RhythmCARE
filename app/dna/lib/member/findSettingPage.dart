import 'package:dna/member/widget/textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      Image.asset('image/logo.png'),
                      SizedBox(
                        height: 58,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              '아이디 찾기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              '비밀번호 찾기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2e2288),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizeBoxH40,
                      Text('  변경할 비밀번호를 입력해주세요', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizeBoxH10,
                      textField(pwCon, '비밀번호'),
                      SizeBoxH10,
                      textField(pw2Con, '비밀번호 확인'),
                      SizedBox(
                        height: 70,
                      ),
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
                          Get.offAll(()=>loginPage());
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
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
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
          ],
        ),
      ),
    );
  }
}
