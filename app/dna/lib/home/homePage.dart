import 'dart:math';

import 'package:dna/controller/GetRhythmController.dart';
import 'package:dna/home/widget/grass/grass.dart';
import 'package:dna/home/widget/heartBeat.dart';
import 'package:dna/home/widget/visualModel.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/GetConnectionController.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  ConnectionController connect = Get.put(ConnectionController());

  //잔디심기
  List<int> walkNum = List.generate(35, (index) => index%2 ==0 ? Random().nextInt(12000) : 4000+ Random().nextInt(8000));

  List<Color> grassColor(List list) {
    List<Color> newList = [];
    list.forEach((e) {
      if (e > 9999) {
        newList.add(Color(0xff009600));
      } else if (e > 7999) {
        newList.add(Color(0xcc009600));
      } else if (e > 5999) {
        newList.add(Color(0x99009600));
      } else if (e > 3999) {
        newList.add(Color(0x66009600));
      } else if (e > 1999) {
        newList.add(Color(0x33009600));
      } else {
        newList.add(Colors.grey);
      }
    });
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          connect.checkConnected();
        });
      },
      child: ListView(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05),
        children: [
          SizeBoxH10,
          // 심박수
          heartBeat(),
          // 스트레스 모델
          visualModel(context, "스트레스"),
          SizeBoxH30,
          horisonLine,
          SizeBoxH30,
          // 피로도
          visualModel(context, "피로도"),
          SizeBoxH30,
          horisonLine,
          SizeBoxH30,
          // 잔디심기
          grass(walkNum: walkNum ,colorList: grassColor(walkNum),),
          SizeBoxH30,
        ],
      ),
    );
  }
}
