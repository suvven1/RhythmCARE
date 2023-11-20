import 'package:dna/controller/GetController.dart';
import 'package:dna/home/widget/grass.dart';
import 'package:dna/home/widget/heartBeat.dart';
import 'package:dna/home/widget/testWidget.dart';
import 'package:dna/home/widget/visualModel.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  // 스트레스 바
  // 피로도 바
  // 수치에 따른 낮은/높은 표시, 표정 표시

  // 심박수

  // 스트레스/피로도
  bool valueHigh = false;

  //잔디심기
  List<int> walkNum = List.filled(35, 0);

  List<Color> grassColor(List list) {
    walkNum[0] = 10000; // test용 값 - DB입력 후 지우기
    walkNum[2] = 6000; // test용 값 - DB입력 후 지우기
    List<Color> newList = [];
    list.forEach((e) {
      if (e > 9999) {
        newList.add(Colors.green);
      } else if (e > 5999) {
        newList.add(Colors.lightGreen);
      } else {
        newList.add(Colors.grey);
      }
    });
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ReactiveController());
    return GetX<ReactiveController>(
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              showToast("화면새로고침 완료");
            });
          },
          child: ListView(
            children: [
              heartbeatTestWidget(),
              // 심박수
              heartBeat(controller.hearBeatNum.value),
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
            ],
          ),
        );
      },
    );
  }
}
