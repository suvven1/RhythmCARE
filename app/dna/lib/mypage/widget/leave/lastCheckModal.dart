import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../../../member/loginPage.dart';
import '../../GetMyPageController.dart';
import '../../myPage.dart';


//탈퇴 여부 최종 확인 모달창
showFinalCheck(context, idCon, pwCon) {
  MypageController mypage = Get.put(MypageController());

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
