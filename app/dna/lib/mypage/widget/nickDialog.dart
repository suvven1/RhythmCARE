import 'package:dna/member/widget/textFieldCheck.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class nickDialog extends StatefulWidget {
  const nickDialog({super.key});

  @override
  State<nickDialog> createState() => _nickDialogState();
}

class _nickDialogState extends State<nickDialog> {
  final TextEditingController nickCon = TextEditingController();

  bool useableNick = false;
  String useableNickText = '';

  // 닉네임 유효성 체크 함수
  void checkNickUseable(String text) {
    setState(() {
      if (text == "") {
        useableNick = false;
        useableNickText = '';
      } else if (text.length < 2 || text.length > 6) {
        useableNick = false;
        useableNickText = '    * 올바른 닉네임을 입력해주세요.';
      } else {
        useableNick = false;
        useableNickText = '    * 닉네임 중복 확인을 해주세요.';
      }
    });
  }

  // 닉네임 중복검사 함수
  void checkNickDup() async {
    String url = "http://115.95.222.206:80/user/join/nickDupCheck";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'nick': nickCon.text}));
    // 닉네임 중복검사 결과를 받아와 변수에 저장
    var resData = jsonDecode(res.body)["nickDupResult"];
    setState(() {
      if (resData) {
        useableNick = resData;
      } else {
        useableNick = resData;
        useableNickText = '    * 중복된 닉네임 입니다.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('닉네임 변경 창'),
          textFieldCheck(
            Con: nickCon,
            idpw: '닉네임을 입력하세요.',
            checkIcon: useableNick,
            checkUseable: checkNickUseable,
            checkDup: checkNickDup,
          ),
          Text(useableNickText),
          SizeBoxH20,
          ElevatedButton(
              onPressed: () {
                // nickCon.text 닉네임 db에 넣어주십쇼
                Get.back();
              },
              child: Text('닉네임 변경하기'))
        ],
      ),
    );
  }
}
