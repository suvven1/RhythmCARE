import 'dart:convert';

import 'package:dna/controller/GetMyPageController.dart';
import 'package:dna/member/loginPage.dart';
import 'package:dna/mypage/widget/infoContainer.dart';
import 'package:dna/mypage/widget/profileImage.dart';
import 'package:dna/mypage/widget/profileNick.dart';
import 'package:dna/snackBarMessage/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../widget/sizeBox.dart';

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  State<myPage> createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  final MypageController userDataCon = Get.put(MypageController());
  bool isLoding = true;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void logout() async {
    final loginDataStorage = await SharedPreferences.getInstance();
    loginDataStorage.clear();
    Get.off(loginPage());
  }

  void getUserData() async {
    final loginDataStorage = await SharedPreferences.getInstance();
    final id = loginDataStorage.getString('id') ?? '';

    String url = "http://115.95.222.206:80/user/getUserData";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}));

    // 통신 결과를 받아와 변수에 저장
    var userData = jsonDecode(res.body)["userData"];

    setState(() {
      if (userData != false) {
        userDataCon.setUserData(userData);
        isLoding=false;
      }else{
        showSnackBar(context, '유저 정보 갱신 실패', 2);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getUserData();
          });
        },
        child: isLoding ? Center(child: CircularProgressIndicator()) :ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.05),
              width: double.infinity,
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(alignment: Alignment.centerRight, child: ElevatedButton(onPressed: (){logout();}, child: Text("로그아웃"))),
                  profileImage(imageData: userDataCon.imageData.value),
                  profileNick(userDataCon.nick.value),
                  SizeBoxH10,
                  infoContainer(userDataCon.infomationGuard.value, userDataCon.informationUser.value, context),
                  SizeBoxH30,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
