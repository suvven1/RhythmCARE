import 'package:dna/home/stressPage.dart';
import 'package:dna/home/tiredPage.dart';
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
  // 잔디 심기


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
          child: Column(
            children: [
              // 심박수
              heartBeat(100),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('걸음 수 잔디밭'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('오늘의 걸음 수에 따라 잔디를 채울 수 있어요'),
                          Text('6000보 이상은 연한 잔디,'),
                          Text('10000보 이상은 진한 잔디가 채워져요!')
                        ],
                      ),
                      Text('6750걸음')
                    ],
                  ),
                ],
              ),
              SizeBoxH30,
              // _gridView
            ],
          ),
        ),
      ),
    );
    ;
    ;
  }
}
