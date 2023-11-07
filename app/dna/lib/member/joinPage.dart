import 'package:dna/member/widget/textField.dart';
import 'package:flutter/material.dart';

import '../widget/sizeBox.dart';
import 'join2Page.dart';

class joinPage extends StatefulWidget {
  const joinPage({super.key});

  @override
  State<joinPage> createState() => _joinPageState();
}

class _joinPageState extends State<joinPage> {
  final idCon = TextEditingController();
  final pwCon = TextEditingController();
  final pw2Con = TextEditingController();
  final nameCon = TextEditingController();
  final birthCon = TextEditingController();
  final genderCon = TextEditingController();
  final phoneCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('image/logo_low.png'),
                Text(
                  '보호자와 기기 사용자가 같이 사용할',
                ),
                Text('아이디/비밀번호 입니다.'),
                textField(idCon, "아이디"),
                SizeBoxH10,
                textField(pwCon, "비밀번호"),
                SizeBoxH10,
                textField(pw2Con, '비밀번호 확인'),
                SizeBoxH40,
                Text('보호자 정보를 입력해주세요'),
                textField(nameCon, '보호자 성명'),
                SizeBoxH10,
                textField(birthCon, '보호자 생년월일 8자리'),
                SizeBoxH10,
                textField(genderCon, '보호자 성별'),
                SizeBoxH10,
                textField(phoneCon, '보호자 휴대폰 번호'),
                SizeBoxH50,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2e2288)),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: const Center(child: Text('다음 페이지')),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => join2Page()));
                  },
                ),
                SizeBoxH50,
                SizeBoxH50,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
