import 'package:dna/home/stressPage.dart';
import 'package:dna/home/tiredPage.dart';
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
              Stack(
                children: [
                  Image.asset('image/heart.gif'),
                  Center(
                    heightFactor: 3,
                    child: Column(
                      children: [
                        Text(
                          '98',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 65),
                        ),
                        Text(
                          'bpm',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  )
                ],
              ),
              // 스트레스 모델
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>stressPage()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('현재 스트레스 지수'),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        Container(
                          margin: EdgeInsets.all(6),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '낮음',
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          '높음',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '현재 스트레스는',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '낮은',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Text(
                                  ' 상태입니다.',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Image.asset(
                          'image/heart.gif',
                          height: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black)),
              ),
              SizedBox(
                height: 30,
              ),
              // 피로도
              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.black
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>tiredPage()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('현재 피로도 지수'),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        Container(
                          margin: EdgeInsets.all(6),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '낮음',
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          '높음',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '현재 피로도는',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '낮은',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Text(
                                  ' 상태입니다.',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Image.asset(
                          'image/heart.gif',
                          height: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black)),
              ),
              SizedBox(
                height: 30,
              ),
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
              SizedBox(
                height: 30,
              ),
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
