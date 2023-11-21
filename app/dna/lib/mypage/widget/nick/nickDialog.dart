import 'package:dna/member/widget/textFieldCheck.dart';
import 'package:dna/mypage/myPage.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

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

  // 닉네임 변경 함수
  void changeNick() async {
    final loginDataStorage = await SharedPreferences.getInstance();
    final id = loginDataStorage.getString('id') ?? '';

    String url = "http://115.95.222.206:80/user/changeNick";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'id': id,'nick': nickCon.text}));

    // 닉네임 변경 결과를 받아와 변수에 저장
    var resData = jsonDecode(res.body)["changeNickResult"];
    setState(() {
      if (resData) {
        Get.back(result: true);
        showToast('닉네임 변경이 완료 되었습니다.');
      } else {
        showToast('[네트워크 에러] 닉네임 변경이 실패 하였습니다.');
      }
    });
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
                  '  변경할 닉네임을 입력해주세요.',
                  style: TextStyle(fontSize: 17),
                ),
                SizeBoxH10,
                textFieldCheck(
                  Con: nickCon,
                  idpw: '닉네임을 입력하세요.',
                  checkIcon: useableNick,
                  checkUseable: checkNickUseable,
                  checkDup: checkNickDup,
                ),
                useableNick
                    ? Text(
                        '    * 사용 가능한 닉네임 입니다.',
                        style: TextStyle(color: Colors.green[900]),
                      )
                    : Text(
                        useableNickText,
                        style: TextStyle(color: Colors.red[900]),
                      ),
                SizeBoxH30,
                ElevatedButton(
                  onPressed: () {
                    changeNick();
                  },
                  child: Text('닉네임 변경'),
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
