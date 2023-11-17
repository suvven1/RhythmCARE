import 'dart:convert';

import 'package:dna/member/widget/textField.dart';
import 'package:dna/member/widget/textFieldCheck.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../widget/sizeBox.dart';
import 'join2Page.dart';

class joinPage extends StatefulWidget {
  const joinPage({super.key});

  @override
  State<joinPage> createState() => _joinPageState();
}

class _joinPageState extends State<joinPage> {
  final NickCon = TextEditingController();
  final idCon = TextEditingController();
  final pwCon = TextEditingController();
  final pw2Con = TextEditingController();

  int useableNick = 0;
  int useableId = 0;
  int useablePw = 0;
  int useablePw2 = 0;

  // test용 변수
  // 중복확인 버튼 클릭 시,
  // 해당 변수와 textField의 string이 같으면 true를 반환함.
  String sameNick = 'test';
  String sameId = 'test';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pwCon.addListener(() {

    });
    pw2Con.addListener(() {

    });
  }


  // 닉네임 중복검사 함수
  void _useable(){
    setState(() {
      NickCon.text == '' ? useableNick = 0 : NickCon.text == sameNick ? useableNick = 1 : useableNick = 2;
    });
  }
  // 아이디 중복검사 함수
  void _useable2(){
    setState(() {
      idCon.text == '' ? useableId = 0 : idCon.text == sameId ? useableId = 1 : useableId = 2;
    });
  }
  // 비밀번호 가능?
  void _pwState(String check, TextEditingController textCon){
    setState(() {
      useablePw = textCon.text=='' ? 0 : textCon.text == check ? 1 : 2;
    });
  }
  // 비밀번호 확인
  void _pwState2(String check, TextEditingController textCon){
    setState(() {
      useablePw2 = textCon.text=='' ? 0 : textCon.text == check ? 1 : 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[200],
          child: ListView(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('image/logo_low.png'),
                  Text(
                    '보호자와 기기 사용자가 같이 사용할', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text('아이디/비밀번호 입니다.', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  SizeBoxH10,
                  textFieldCheck(Con: NickCon, hint: "닉네임", checkIcon: useableNick, checkFt: _useable, ),
                  Text(useableNick==0 ? '' : useableNick == 1 ? '    *사용가능한 닉네임입니다.' : '', style: TextStyle(color: Colors.green[900]),),
                  SizeBoxH10,
                  textFieldCheck(Con: idCon, hint: "아이디", checkIcon: useableId, checkFt: _useable2),
                  Text(useableId==0 ? '' : useableId == 1 ? '    *사용가능한 아이디입니다.' : '', style: TextStyle(color: Colors.green[900]),),
                  SizeBoxH10,
                  textFieldCheck(Con: pwCon, hint: "비밀번호", checkIcon: useablePw),
                  Text(useablePw==0 ? '' : useablePw == 1 ? '    *사용가능한 비밀번호입니다.' : '', style: TextStyle(color: Colors.green[900]),),
                  SizeBoxH10,
                  textFieldCheck(Con: pw2Con, hint: '비밀번호 확인', checkIcon: useablePw2),
                  Text(useablePw2==0 ? '' : useablePw2 == 1 ? '    *같은 비밀번호를 입력하셨습니다.' : '', style: TextStyle(color: Colors.green[900]),),
                  SizedBox(height: 204,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2e2288)),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: const Center(child: Text('다음 페이지')),
                    ),
                    onPressed: () {
                      Get.to(()=>join2Page());
                    },
                  ),
                  SizeBoxH50,
                  SizeBoxH50,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
