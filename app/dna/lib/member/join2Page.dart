import 'dart:convert';

import 'package:dna/member/joinPage.dart';
import 'package:dna/member/widget/textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../widget/sizeBox.dart';
import 'loginPage.dart';

class join2Page extends StatefulWidget {
  const join2Page({super.key});

  @override
  State<join2Page> createState() => _join2PageState();
}

class _join2PageState extends State<join2Page> {
  final nameCon = TextEditingController();
  final birthCon = TextEditingController();
  final phoneCon = TextEditingController();
  int gender = 0;
  final name2Con = TextEditingController();
  final birth2Con = TextEditingController();
  final phone2Con = TextEditingController();
  int gender2 = 0;

  // 회원가입 서버 통신 함수 구현 예정
  // void join(bool who, idCon, pwCon) async {
  //   String url = "http://192.168.70.134:3333/user/login";
  //   http.Response res = await http.post(
  //       Uri.parse(url),
  //       headers: <String, String>{'Content-Type':'application/json'},
  //       body: jsonEncode(
  //           {
  //             'user' : who,
  //             'id' : idCon.text,
  //             'pw' : pwCon.text
  //           }
  //       )
  //   );
  //
  //   // 로그인 결과를 받아와 변수에 저장
  //   var resData = jsonDecode(res.body);
  //   print(resData);
  //
  //   setState(() {
  //     if(resData["loginResult"] != false){
  //       Get.off(()=> join2Page());
  //     }
  //   });
  // }
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
                    '보호자 정보를 입력해주세요',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  textField(nameCon, '보호자 성명'),
                  SizeBoxH10,
                  textField(birthCon, '보호자 생년월일 8자리'),
                  SizeBoxH10,
                  textField(phoneCon, '보호자 휴대폰 번호'),
                  SizeBoxH10,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            gender = 1;
                          });
                        },
                        child: Text(
                          '남자',
                          style: TextStyle(
                              fontSize: 20,
                              color: gender == 1
                                  ? Color(0xffffffff)
                                  : Color(0xff000000)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: gender == 1
                                ? Color(0xff2e2288)
                                : Color(0xffffffff),
                            elevation: 0,
                            fixedSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            gender = 2;
                          });
                        },
                        child: Text(
                          '여자',
                          style: TextStyle(
                              fontSize: 20,
                              color: gender == 2
                                  ? Color(0xffffffff)
                                  : Color(0xff000000)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: gender == 2
                                ? Color(0xff2e2288)
                                : Color(0xffffffff),
                            elevation: 0,
                            fixedSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      )),
                    ],
                  ),
                  SizeBoxH20,
                  Text(
                    '기기를 사용할 사용자의 정보를 입력해주세요',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  textField(name2Con, '사용자 성명'),
                  SizeBoxH10,
                  textField(birth2Con, '사용자 생년월일 8자리'),
                  SizeBoxH10,
                  textField(phone2Con, '사용자 휴대폰 번호'),
                  SizeBoxH10,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gender2 = 1;
                              });
                            },
                            child: Text(
                              '남자',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: gender2 == 1
                                      ? Color(0xffffffff)
                                      : Color(0xff000000)),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: gender2 == 1
                                    ? Color(0xff2e2288)
                                    : Color(0xffffffff),
                                elevation: 0,
                                fixedSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gender2 = 2;
                              });
                            },
                            child: Text(
                              '여자',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: gender2 == 2
                                      ? Color(0xffffffff)
                                      : Color(0xff000000)),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: gender2 == 2
                                    ? Color(0xff2e2288)
                                    : Color(0xffffffff),
                                elevation: 0,
                                fixedSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          )),
                    ],
                  ),
                  SizeBoxH30,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2e2288)),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: const Center(child: Text('회원가입')),
                    ),
                    onPressed: () {
                      Get.offAll(() => loginPage());
                    },
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: Container(
                      width: double.infinity,
                      height: 25,
                      child: const Center(child: Text('이전 페이지')),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
