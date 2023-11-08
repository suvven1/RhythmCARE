import 'package:dna/member/widget/textField.dart';
import 'package:flutter/material.dart';

import '../widget/sizeBox.dart';
import 'loginPage.dart';

class join2Page extends StatefulWidget {
  const join2Page({super.key});

  @override
  State<join2Page> createState() => _join2PageState();
}

class _join2PageState extends State<join2Page> {
  final name2Con = TextEditingController();
  final birth2Con = TextEditingController();
  final gender2Con = TextEditingController();
  final phone2Con = TextEditingController();

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
                  '기기를 사용할 사용자의 정보를 입력해주세요',
                ),
                textField(name2Con, '사용자 성명'),
                SizeBoxH10,
                textField(birth2Con, '사용자 생년월일 8자리'),
                SizeBoxH10,
                textField(gender2Con, '사용자 성별'),
                SizeBoxH10,
                textField(phone2Con, '사용자 휴대폰 번호'),
                SizedBox(
                  height: 294,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2e2288)),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: const Center(child: Text('회원가입')),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => loginPage()));
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey),
                  child: Container(
                    width: double.infinity,
                    height: 25,
                    child: const Center(child: Text('이전 페이지')),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
