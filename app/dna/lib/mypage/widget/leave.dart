import 'dart:convert';

import 'package:dna/member/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:dna/member/widget/textField.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../GetMyPageController.dart';
import '../myPage.dart';
leave(context) {
  MypageController mypage = Get.put(MypageController());
  TextEditingController idCon = TextEditingController();

  TextEditingController pwCon = TextEditingController();

  // 회원탈퇴 서버 통신 함수
  void delete(idCon, pwCon) async {
    if(idCon.text == mypage.managerID.value && pwCon.text == mypage.managerPW.value){
      String url = "http://192.168.70.134:3333/user/delete";
      http.Response res = await http.post(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode({'id': idCon.text}));

      // 탈퇴 결과를 받아와 변수에 저장
      var resData = jsonDecode(res.body);
      if(resData["deleteResult"]){
        Get.off(()=> loginPage());
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('탈퇴가 완료되었습니다.'),
              duration: const Duration(seconds: 1),)
        );
      }
    }else{
      Get.off(()=> myPage());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디 또는 비밀번호가 일치하지 않습니다.'),
        duration: const Duration(seconds: 3),)
      );
    }
  }

  //탈퇴 여부 최종 확인 모달창
  void showFinalCheck() {
    showDialog(
      context: context,
      barrierDismissible: false, // 배경 터치로 닫히지 않도록 설정
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                      child: Column(
                        children: [
                          Text(
                            "탈퇴시 복구가 불가능 합니다.",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "정말 탈퇴 하시겠습니까?",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2e2288),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 40,
                          child: Center(
                              child: Text(
                            '확인',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                        onPressed: () {
                          delete(idCon,pwCon);
                        },
                      ),
                      const SizedBox(width: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2e2288),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 40,
                          child: Center(
                              child: Text(
                            '취소',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 탈퇴 인증 모달장
  void showPopUp() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Image.asset(
                    'image/logo.png',
                    width: MediaQuery.of(context).size.width * 0.65,
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                    child: textField(idCon, "아이디"),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                    child: textField(pwCon, "비밀번호"),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2e2288),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.54,
                      height: 50,
                      child: Center(
                        child: Text(
                          '탙퇴하기',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onPressed: () {
                      showFinalCheck();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }



  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("회원 탈퇴"),
      Text('탈퇴 후 복구할 수 없습니다. 신중하게 결정해주세요.'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('회원탈퇴'),
          ElevatedButton(
            onPressed: () {
              showPopUp();
            },
            child: Text('탈퇴하기'),
            style: ButtonStyle(),
          )
        ],
      )
    ],
  );
}
