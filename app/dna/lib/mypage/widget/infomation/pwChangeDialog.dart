import 'dart:convert';

import 'package:dna/member/widget/textFieldCheck.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../url.dart';

class pwChangeDialog extends StatefulWidget {
  const pwChangeDialog({super.key});

  @override
  State<pwChangeDialog> createState() => _pwChangeDialogState();
}

class _pwChangeDialogState extends State<pwChangeDialog> {
  final TextStyle style = TextStyle(fontSize: 17);
  final TextEditingController pwCon = TextEditingController();
  final TextEditingController newPwCon = TextEditingController();
  final TextEditingController newPw2Con = TextEditingController();

  bool checknull = false;
  bool useablePw = false;
  bool useableNewPw = false;
  bool useableNewPw2 = false;

  // 유효성 확인 텍스트
  String useablePwText = '';
  String useableNewPwText = '';
  String useableNewPw2Text = '';

  // 기존 비밀번호 유효성 체크 함수
  void checkPwUseable(String text) {
    setState(() {
      if (text == "") {
        useablePw = false;
        useablePwText = '';
      } else if (text.length < 8) {
        checknull = false;
        useablePw = false;
        useablePwText = '    * 올바른 비밀번호를 입력해주세요.';
      } else {
        checknull = true;
        useablePwText = '';
      }
    });
  }

  // 신규 비밀번호 유효성 체크 함수
  void checkNewPwUseable(String text) {
    setState(() {
      if (text == "") {
        useableNewPw = false;
        useableNewPwText = '';
      } else if (text.length < 8) {
        useableNewPw = false;
        useableNewPwText = '    * 올바른 비밀번호를 입력해주세요.';
      } else if (text == pwCon.text) {
        useableNewPw = false;
        useableNewPwText = '    * 기존 비밀번호와 다르게 입력해주세요.';
      } else {
        useableNewPw = true;
      }
    });
  }

  // 비밀번호확인 유효성 체크 함수
  void checkNewPw2Useable(String text) {
    setState(() {
      if (text == "") {
        useableNewPw2 = false;
        useableNewPw2Text = '';
      } else if (text != newPwCon.text) {
        useableNewPw2 = false;
        useableNewPw2Text = '    * 비밀번호가 일치하지 않습니다.';
      } else {
        useableNewPw2 = true;
      }
    });
  }

  // 기존 비밀번호 확인 함수
  void checkOldPw() async {
    final loginDataStorage = await SharedPreferences.getInstance();
    final id = loginDataStorage.getString('id') ?? '';

    String url = "http://${URL.ip}/user/login";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'user': "mem", 'id': id, 'pw': pwCon.text}));

    // 비밀번호 확인 결과를 받아와 변수에 저장
    var loginResult = jsonDecode(res.body)["loginResult"];

    setState(() {
      if (loginResult.runtimeType != bool) {
        changePw();
      } else {
        checknull = false;
        useablePw = false;
        useablePwText = '    * 기존 비밀번호와 일치하지 않습니다.';
      }
    });
  }

  // 비밀번호 변경 함수
  void changePw() async {
    final loginDataStorage = await SharedPreferences.getInstance();
    final id = loginDataStorage.getString('id') ?? '';

    String url = "http://${URL.ip}/user/changePw";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'id': id, 'changePw': newPwCon.text}));

    // 탈퇴 결과를 받아와 변수에 저장
    var changePwResult = jsonDecode(res.body)["changePwResult"];
    if (changePwResult) {
      checknull = false;
      useablePw = true;
      Get.back();
      showToast('비밀번호 변경이 완료되었습니다.');
    } else {
      showToast('네트워크 에러 : 비밀번호를 변경하지 못했습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        backgroundColor: Colors.grey[200],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('image/logo_low.png'),
                Text(
                  '  기존 비밀번호 입력 후',
                  style: style,
                ),
                Text(
                  '  변경할 비밀번호를 입력해주세요.',
                  style: style,
                ),
                SizeBoxH10,
                textFieldCheck(
                    Con: pwCon,
                    idpw: "기존 비밀번호",
                    checkIcon: useablePw,
                    checkUseable: checkPwUseable,
                    checkNull: checknull),
                useablePw
                    ? Text(
                        '    *기존 비밀번호와 일치합니다.',
                        style: TextStyle(color: Colors.green[900]),
                      )
                    : Text(
                        useablePwText,
                        style: TextStyle(color: Colors.red[900]),
                      ),
                SizeBoxH10,
                textFieldCheck(
                  Con: newPwCon,
                  idpw: "비밀번호 (8자리 이상)",
                  checkIcon: useableNewPw,
                  checkUseable: checkNewPwUseable,
                ),
                useableNewPw
                    ? Text(
                        '    *사용가능한 비밀번호입니다.',
                        style: TextStyle(color: Colors.green[900]),
                      )
                    : Text(
                        useableNewPwText,
                        style: TextStyle(color: Colors.red[900]),
                      ),
                SizeBoxH10,
                textFieldCheck(
                  Con: newPw2Con,
                  idpw: '비밀번호 확인',
                  checkIcon: useableNewPw2,
                  checkUseable: checkNewPw2Useable,
                ),
                useableNewPw2
                    ? Text(
                        '    *같은 비밀번호를 입력하셨습니다.',
                        style: TextStyle(color: Colors.green[900]),
                      )
                    : Text(
                        useableNewPw2Text,
                        style: TextStyle(color: Colors.red[900]),
                      ),
                SizeBoxH30,
                ElevatedButton(
                  onPressed: () {
                    checkOldPw();
                  },
                  child: Text('변경'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2e2288),
                      minimumSize: Size(double.infinity, 50),
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('취소'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      minimumSize: Size(double.infinity, 40),
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
              ],
            ),
          ),
        ));
  }
}
