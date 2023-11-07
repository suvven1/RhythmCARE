import 'package:dna/mypage/widget/infoContainer.dart';
import 'package:dna/mypage/widget/profileImge.dart';
import 'package:dna/mypage/widget/profileNick.dart';
import 'package:flutter/material.dart';

import '../widget/sizeBox.dart';

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  State<myPage> createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  // 대표 이미지 and 이름
  String imageName = "face.jpg";
  String nickName = "푸르른공원";

  Map<String, dynamic> infomationGuard = {
    "이름": "하병권",
    '휴대폰번호': '010-2720-6279',
    '생년월일': 19950504,
    '아이디': 'admin',
  };
  Map<String, dynamic> informationUser = {
    '이름': '노약자',
    '휴대폰번호': '011-1234-1234',
    '생년월일': 19450101,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.grey[200],
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profileImage(context, imageName),
                SizeBoxH10,
                profileNick(nickName),
                SizeBoxH20,
                infoContainer(infomationGuard, informationUser),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
