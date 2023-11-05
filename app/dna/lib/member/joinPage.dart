import 'package:flutter/material.dart';

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
                    Text('보호자와 기기 사용자가 같이 사용할',),
                    Text('아이디/비밀번호 입니다.'),
                    TextField(
                      controller: idCon,
                      decoration: const InputDecoration(
                        labelText: '아이디',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: pwCon,
                      decoration: const InputDecoration(
                        labelText: '비밀번호',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: pw2Con,
                      decoration: const InputDecoration(
                        labelText: '비밀번호 확인',
                      ),
                    ),
                    SizedBox(height: 40,),
                    Text('보호자 정보를 입력해주세요'),
                    TextField(
                      controller: nameCon,
                      decoration: const InputDecoration(
                        labelText: '보호자 성명',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: birthCon,
                      decoration: const InputDecoration(
                        labelText: '보호자 생년월일 8자리',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: genderCon,
                      decoration: const InputDecoration(
                        labelText: '보호자 성별',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: phoneCon,
                      decoration: const InputDecoration(
                        labelText: '보호자 휴대폰 번호',
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
                        child: const Center(child: Text('다음 페이지')),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>join2Page()));
                      },
                    ),
                    SizedBox(height: 50,)
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