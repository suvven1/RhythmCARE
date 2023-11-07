import 'package:dna/home/stressPage.dart';
import 'package:dna/home/tiredPage.dart';
import 'package:dna/home/widget/grass.dart';
import 'package:dna/home/widget/heartBeat.dart';
import 'package:dna/home/widget/stressModel.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  // Widget _gridView = GridView.builder(
  //   itemCount: 10, // 아이템 갯수
  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //     crossAxisCount: 3, // 행마다 보여줄 아이템 갯수
  //     childAspectRatio: 1/2, // 아이템의 가로 1, 세로 2의 비율
  //     mainAxisSpacing: 10, // 수평 패딩
  //     crossAxisSpacing: 10 // 수직 패딩
  //   ),
  //   itemBuilder: (BuildContext context, int index){
  //     return Container(
  //       width: 10,
  //       height: 10,
  //       margin: EdgeInsets.all(2),
  //       color: Colors.grey,
  //     );
  //   },
  // );

  // 스트레스 바
  // 피로도 바
  // 수치에 따른 낮은/높은 표시, 표정 표시

  // 심박수
  int hearBeatNum = 100;

  //잔디심기
  List<int> walkNum = List.filled(35, 0);
  List<Color> grassColor(List list) {
    walkNum[0] = 10000; // test용 값 - DB입력 후 지우기
    walkNum[2] = 6000; // test용 값 - DB입력 후 지우기
    List<Color> newList = [];
    list.forEach((e) {
      if (e > 9999) {
        newList.add(Colors.green);
      }else if (e > 5999){
        newList.add(Colors.lightGreen);
      }else{
        newList.add(Colors.grey);
      }
    });
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: [
              // 심박수
              heartBeat(hearBeatNum),
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
              grass(grassColor(walkNum)),
              SizeBoxH30,
              // _gridView
            ],
          ),
        ),
      ),
    );
  }
}
