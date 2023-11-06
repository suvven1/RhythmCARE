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
        child: Transform.scale(
          scale: 0.82, // 로그인 화면 여백 지정
          child: Container(
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     width: 1,
            //     color: Colors.black
            //   )
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('image/logo_low.png'),
                    Text('기기를 사용할 사용자의 정보를 입력해주세요',),
                    TextField(
                      controller: name2Con,
                      decoration: const InputDecoration(
                        labelText: '사용자 성명',
                      ),
                    ),
                    SizeBoxH10,
                    TextField(
                      controller: birth2Con,
                      decoration: const InputDecoration(
                        labelText: '사용자 생년월일 8자리',
                      ),
                    ),
                    SizeBoxH10,
                    TextField(
                      controller: gender2Con,
                      decoration: const InputDecoration(
                        labelText: '사용자 성별',
                      ),
                    ),
                    SizeBoxH10,
                    TextField(
                      controller: phone2Con,
                      decoration: const InputDecoration(
                        labelText: '사용자 휴대폰 번호',
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2e2288)
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: const Center(child: Text('회원가입')),
                      ),
                      onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>loginPage()));
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 25,
                        child: const Center(child: Text('이전 페이지')),
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}