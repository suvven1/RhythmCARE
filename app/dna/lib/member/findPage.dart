import 'package:dna/member/widget/textField.dart';
import 'package:dna/member/widget/toggleButton2.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'findSettingPage.dart';
import 'joinPage.dart';

class findPage extends StatefulWidget {
  const findPage({super.key});

  @override
  State<findPage> createState() => _findPageState();
}

class _findPageState extends State<findPage> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController birthCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();

  String findIt = '아이디';

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
        child: ListView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.87,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('image/logo.png'),
                      SizeBoxH50,
                      toggleButton2(context, isSelected, toggleSelect),
                      SizeBoxH30,
                      textField(nameCon, '보호자 성명'),
                      SizeBoxH10,
                      textField(birthCon, '보호자 생년월일 8자리'),
                      SizeBoxH10,
                      textField(phoneCon, '보호자 휴대폰번호'),
                      SizeBoxH40,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff2e2288)),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          child: Center(child: Text('$findIt 찾기')),
                        ),
                        onPressed: () {
                          if(isGuard) {
                            Navigator.pop(context);
                          } else{
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>findSettingPage()));
                          }
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

  // toggle 함수
  void toggleSelect(value) {
    if (value == 0) {
      isGuard = true;
      isUser = false;
      findIt = '아이디';
    } else {
      isGuard = false;
      isUser = true;
      findIt = '비밀번호';
    }
    setState(() {
      isSelected = [isGuard, isUser];
    });
  }
}
