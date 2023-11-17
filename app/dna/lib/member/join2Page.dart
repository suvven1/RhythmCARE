import 'dart:convert';

import 'package:dna/member/joinPage.dart';
import 'package:dna/member/widget/textField.dart';
import 'package:dna/snackBarMessage/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/GetJoinController.dart';
import '../widget/sizeBox.dart';
import 'loginPage.dart';

class join2Page extends StatefulWidget {
  const join2Page({super.key});

  @override
  State<join2Page> createState() => _join2PageState();
}

class _join2PageState extends State<join2Page> {
  JoinController joinController = Get.put(JoinController());
  final nameCon = TextEditingController();
  String mBirth = "";
  final phoneCon = TextEditingController();
  String gender = "null";

  final name2Con = TextEditingController();
  String uBirth = "";
  final phone2Con = TextEditingController();
  String gender2 = "null";

  // 보호자 생년월일 변수
  DateTime mSelectedDate = DateTime.now();
  DateTime mStartDayAdd = DateTime.now();
  DateTime mLastDayAdd = DateTime.now();
  DateTime? mStartDay;
  DateTime? mLastDay;

  // 사용자 생년월일 변수
  DateTime uSelectedDate = DateTime.now();
  DateTime uStartDayAdd = DateTime.now();
  DateTime uLastDayAdd = DateTime.now();
  DateTime? uStartDay;
  DateTime? uLastDay;

  // 입력 내용 확인 및 회원가입 실행 함수
  void checkInputAndJoin(){
    if(
    nameCon.text == "" || name2Con.text == "" ||
    phoneCon.text == "" || phone2Con.text == "" ||
    gender == "null" || gender2 == "null2" ||
    mBirth == "보호자 생년월일" || uBirth == "사용자 생년월일"
    ){
      showSnackBar(context, '회원가입 정보를 빈칸없이 입력해주세요.');
    }else if(checkPhoneNumber()){
      showSnackBar(context, '휴대폰 번호는 숫자로만 입력해주세요.');
    }else{
      join();
    }

  }

  bool checkPhoneNumber(){
    try{
      int.parse(phoneCon.text);
      int.parse(phone2Con.text);
      return false;
    }catch(e){
      return true;
    }
  }

  // 회원가입 서버 통신 함수 구현 예정
  void join() async {
    String url = "http://115.95.222.206:80/user/join";
    http.Response res = await http.post(
        Uri.parse(url),
        headers: <String, String>{'Content-Type':'application/json'},
        body: jsonEncode(
            { "joinData" : {
              'id' : joinController.id,
              'pw' : joinController.pw,
              'mName' : nameCon.text,
              'nick' : joinController.nick,
              'mBirth' : mBirth,
              'mGender' : gender,
              'mPhone' : phoneCon.text,
              'uName' : name2Con.text,
              'uBirth' : uBirth,
              'uGender' : gender2,
              'uPhone' : phone2Con.text,
            }
            }
        )
    );

    // 회원가입 결과를 받아와 변수에 저장
    var resData = jsonDecode(res.body);

    setState(() {
      if(resData["joinResult"]){
        Get.offAll(() => loginPage());
        showSnackBar(context, "회원가입이 완료되었습니다.");
      }
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
                    '보호자 정보를 입력해주세요',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  textField(nameCon, '보호자 성명'),
                  SizeBoxH10,
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          fixedSize: Size(500,double.infinity), alignment: Alignment.centerLeft
                        ),
                        child: Text(
                          mStartDay != null
                              ? mBirth
                              : "보호자 생년월일",
                          style: TextStyle(
                              fontSize: 20,
                              color: mStartDay != null
                                  ? Colors.black
                                  : Colors.grey[600],

                              fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: mStartDay != null
                                ? mStartDay!
                                : mLastDay == null
                                    ? mSelectedDate
                                    : mSelectedDate.isAfter(mLastDay!)
                                        ? mLastDay!
                                        : mSelectedDate,
                            firstDate: DateTime(0),
                            lastDate:
                                mLastDay == null ? DateTime(2030) : mLastDay!,
                          ).then((value) {
                            setState(() {
                              mStartDay = value;
                              mBirth = mStartDay.toString().split(' ')[0];
                            });
                          });

                        },
                      )),
                  SizeBoxH10,
                  textFieldMaxLength(phoneCon, '휴대폰 번호 ex) 01073645432', 11),
                  SizeBoxH10,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            gender = "M";
                          });
                        },
                        child: Text(
                          '남자',
                          style: TextStyle(
                              fontSize: 20,
                              color: gender == "M"
                                  ? Color(0xffffffff)
                                  : Color(0xff000000)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: gender == "M"
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
                            gender = "W";
                          });
                        },
                        child: Text(
                          '여자',
                          style: TextStyle(
                              fontSize: 20,
                              color: gender == "W"
                                  ? Color(0xffffffff)
                                  : Color(0xff000000)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: gender == "W"
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
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            fixedSize: Size(500,double.infinity), alignment: Alignment.centerLeft
                        ),
                        child: Text(
                          uStartDay != null
                              ? uBirth
                              : "사용자 생년월일",
                          style: TextStyle(
                              fontSize: 20,
                              color: uStartDay != null
                                  ? Colors.black
                                  : Colors.grey[600],

                              fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: uStartDay != null
                                ? uStartDay!
                                : uLastDay == null
                                ? uSelectedDate
                                : uSelectedDate.isAfter(uLastDay!)
                                ? uLastDay!
                                : uSelectedDate,
                            firstDate: DateTime(0),
                            lastDate:
                            uLastDay == null ? DateTime(2030) : uLastDay!,
                          ).then((value) {
                            setState(() {
                              uStartDay = value;
                              uBirth = uStartDay.toString().split(' ')[0];
                            });
                          });

                        },
                      )),
                  SizeBoxH10,
                  textFieldMaxLength(phone2Con, '휴대폰 번호 ex) 01073645432', 11),
                  SizeBoxH10,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            gender2 = "M";
                          });
                        },
                        child: Text(
                          '남자',
                          style: TextStyle(
                              fontSize: 20,
                              color: gender2 == "M"
                                  ? Color(0xffffffff)
                                  : Color(0xff000000)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: gender2 == "M"
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
                            gender2 = "W";
                          });
                        },
                        child: Text(
                          '여자',
                          style: TextStyle(
                              fontSize: 20,
                              color: gender2 == "W"
                                  ? Color(0xffffffff)
                                  : Color(0xff000000)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: gender2 == "W"
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
                      checkInputAndJoin();
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
