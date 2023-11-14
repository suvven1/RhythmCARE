import 'package:flutter/material.dart';
import 'package:dna/member/widget/textField.dart';
import 'package:dna/mypage/widget/leave/lastCheckModal.dart';

// 탈퇴 인증 모달장
showPopUp(context) {

  TextEditingController idCon = TextEditingController();
  TextEditingController pwCon = TextEditingController();

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
                    showFinalCheck(context, idCon, pwCon);
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