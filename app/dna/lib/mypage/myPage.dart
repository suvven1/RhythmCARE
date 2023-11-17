import 'package:dna/controller/GetMyPageController.dart';
import 'package:dna/mypage/widget/infoContainer.dart';
import 'package:dna/mypage/widget/profileImage.dart';
import 'package:dna/mypage/widget/profileNick.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widget/sizeBox.dart';

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  State<myPage> createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  final MypageController mypage = Get.put(MypageController());
  @override
  Widget build(BuildContext context) {

    Map<String, String> infomationGuard = {
      "이름": mypage.managerName.value,
      '휴대폰번호': mypage.managerHP.value,
      '생년월일': mypage.managerBD.value,
      '아이디': mypage.managerID.value,
    };
    Map<String, String> informationUser = {
      '이름': mypage.userName.value,
      '휴대폰번호': mypage.userHP.value,
      '생년월일': mypage.userBD.value,
    };
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.1),
            width: double.infinity,
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profileImage(context, mypage.imageData),
                SizeBoxH10,
                profileNick(mypage.nick.value),
                SizeBoxH20,
                infoContainer(infomationGuard, informationUser, context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
