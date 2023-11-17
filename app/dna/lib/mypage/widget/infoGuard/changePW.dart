import 'package:flutter/material.dart';
import 'package:dna/member/widget/textField.dart';

import '../../../member/widget/textFieldCheck.dart';
import '../../../widget/sizeBox.dart';

// 비밀번호 변경 모달장
showChangePwDialog(context) {

  final pwCon = TextEditingController();
  final pw2Con = TextEditingController();
  bool useablePw = false;
  bool useablePw2 = false;

  // 비밀번호 유효성 체크 함수
  void checkPwUseable(String text){

  }

  // 비밀번호확인 유효성 체크 함수
  void checkPw2Useable(String text){

  }


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
                textFieldCheck(Con: pwCon, idpw: "비밀번호", checkIcon: useablePw, checkUseable: checkPwUseable,),
                Text(useablePw ? '    *사용가능한 비밀번호입니다.' : '', style: TextStyle(color: Colors.green[900]),),
                SizeBoxH10,
                textFieldCheck(Con: pw2Con, idpw: '비밀번호 확인', checkIcon: useablePw2, checkUseable: checkPw2Useable,),
                Text(useablePw2 ? '    *같은 비밀번호를 입력하셨습니다.' : '', style: TextStyle(color: Colors.green[900]),),
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
                    // showFinalCheck(context, idCon, pwCon);
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