import 'dart:convert';

import 'package:dna/controller/GetJoinController.dart';
import 'package:dna/member/widget/textField.dart';
import 'package:dna/member/widget/textFieldCheck.dart';
import 'package:dna/snackBarMessage/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:http/http.dart' as http;
import '../widget/sizeBox.dart';
import 'join2Page.dart';

class joinPage extends StatefulWidget {
  const joinPage({super.key});

  @override
  State<joinPage> createState() => _joinPageState();
}

class _joinPageState extends State<joinPage> {
  JoinController joinController = Get.put(JoinController());
  final nickCon = TextEditingController();
  final idCon = TextEditingController();
  final pwCon = TextEditingController();
  final pw2Con = TextEditingController();

  bool useableNick = false;
  bool useableId = false;
  bool useablePw = false;
  bool useablePw2 = false;

  // 유효성 확인 텍스트
  String useableNickText = '';
  String useableIdText = '';
  String useablePwText = '';
  String useablePw2Text = '';

  // 닉네임 유효성 체크 함수
  void checkNickUseable(String text){
    setState(() {
      if(text == ""){
        useableNick = false;
        useableNickText = '';
      }else if(text.length < 2 || text.length > 6){
        useableNick = false;
        useableNickText = '    * 올바른 닉네임을 입력해주세요.';
      }else{
        useableNick = false;
        useableNickText = '    * 닉네임 중복 확인을 해주세요.';
      }
    });
  }

  // 닉네임 중복검사 함수
  void checkNickDup() async {
    String url = "http://192.168.1.106:3333/user/join/nickDupCheck";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'nick': nickCon.text}));
    // 닉네임 중복검사 결과를 받아와 변수에 저장
    var resData = jsonDecode(res.body)["nickDupResult"];
    setState(() {
      if(resData){
        useableNick = resData;
      }else{
        useableNick = resData;
        useableNickText = '    * 중복된 닉네임 입니다.';
      }
    });
  }

  // 아이디 유효성 체크 함수
  void checkIdUseable(String text){
    setState(() {
      if(text == ""){
        useableId = false;
        useableIdText = '';
      }else if(text.length < 5 || text.length > 10){
        useableId = false;
        useableIdText = '    * 올바른 아이디를 입력해주세요.';
      }else{
        useableId = false;
        useableIdText = '    * 아이디 중복 확인을 해주세요.';
      }
    });
  }

  // 아이디 중복검사 함수
  void checkIdDup() async {
    String url = "http://192.168.1.106:3333/user/join/idDupCheck";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'id': idCon.text}));
    // 닉네임 중복검사 결과를 받아와 변수에 저장
    var resData = jsonDecode(res.body)["idDupResult"];
    setState(() {
      if(resData){
        useableId = resData;
      }else{
        useableId = resData;
        useableIdText = '    * 중복된 아이디 입니다.';
      }
    });
  }

  // 비밀번호 유효성 체크 함수
  void checkPwUseable(String text){
    setState(() {
      if(text == ""){
        useablePw = false;
        useablePwText = '';
      }else if(text.length < 8){
        useablePw = false;
        useablePwText = '    * 올바른 비밀번호를 입력해주세요.';
      }else{
        useablePw = true;
      }
    });
  }

  // 비밀번호확인 유효성 체크 함수
  void checkPw2Useable(String text){
    setState(() {
      if(text == ""){
        useablePw2 = false;
        useablePw2Text = '';
      }else if(text != pwCon.text){
        useablePw2 = false;
        useablePw2Text = '    * 비밀번호가 일치하지 않습니다.';
      }else{
        useablePw2 = true;
      }
    });
  }

  // 입력 내용 확인 및 다음 페이지 이동
  void checkInputAndGoNextPage(){

    if(useableNick && useableId && useablePw && useablePw2){
      List<String> loginData = [idCon.text, pwCon.text, nickCon.text];
      joinController.setLoginData(loginData);
      Get.to(() => join2Page());
    }else{
      showSnackBar(context, '회원가입 정보를 올바르게 입력해주세요.', 2);
    }

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
                    '보호자와 기기 사용자가 같이 사용할',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '아이디/비밀번호 입니다.',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizeBoxH10,
                  textFieldCheck(
                    Con: nickCon,
                    idpw: "닉네임 (2~6글자)",
                    checkIcon: useableNick,
                    checkDup: checkNickDup,
                    checkUseable: checkNickUseable,
                  ),
                  useableNick
                      ? Text(
                          '    *사용가능한 닉네임입니다.',
                          style: TextStyle(color: Colors.green[900]),
                        )
                      : Text(
                    useableNickText,
                          style: TextStyle(color: Colors.red[900]),
                        ),
                  SizeBoxH10,
                  textFieldCheck(
                      Con: idCon,
                      idpw: "아이디 (5~10글자)",
                      checkIcon: useableId,
                      checkDup: checkIdDup,
                      checkUseable: checkIdUseable,
                  ),

                  useableId
                      ? Text(
                    '    *사용가능한 아이디입니다.',
                    style: TextStyle(color: Colors.green[900]),
                  )
                      : Text(
                    useableIdText,
                    style: TextStyle(color: Colors.red[900]),
                  ),
                  SizeBoxH10,
                  textFieldCheck(
                      Con: pwCon, idpw: "비밀번호 (8자리 이상)", checkIcon: useablePw, checkUseable: checkPwUseable,),
                  useablePw
                      ? Text(
                    '    *사용가능한 비밀번호입니다.',
                    style: TextStyle(color: Colors.green[900]),
                  )
                      : Text(
                    useablePwText,
                    style: TextStyle(color: Colors.red[900]),
                  ),
                  SizeBoxH10,
                  textFieldCheck(
                      Con: pw2Con, idpw: '비밀번호 확인', checkIcon: useablePw2, checkUseable: checkPw2Useable,),
                  useablePw2
                      ? Text(
                    '    *같은 비밀번호를 입력하셨습니다.',
                    style: TextStyle(color: Colors.green[900]),
                  )
                      : Text(
                    useablePw2Text,
                    style: TextStyle(color: Colors.red[900]),
                  ),
                  SizedBox(
                    height: 204,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2e2288)),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: const Center(child: Text('다음 페이지')),
                    ),
                    onPressed: () {
                      checkInputAndGoNextPage();
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
