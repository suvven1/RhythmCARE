import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/GetConnectionController.dart';

connect_step_3(context) {
  ConnectionController connect = Get.put(ConnectionController());
  return Container(
    height: 340,
    child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "다음 항목을 확인해 보세요.",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff2e2288),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
          height: MediaQuery.of(context).size.width * 0.43,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Color(0xff2e2288),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text("1",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "스마트 밴드의 전원을 ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2e2288)),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "켜 주세요.",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2e2288)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Color(0xff2e2288),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text("2",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "장치가 가까이 있는지",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2e2288)),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "확인해 주세요.",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2e2288)),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff2e2288),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  // 원하는 border radius 설정
                  side: BorderSide(
                      color: Color(0xff2e2288), width: 2), // 테두리 스타일 설정
                ),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 45)),
            onPressed: () {
              connect.steps.value = 2;
              connect.isWidgetLoding.value = true;
            },
            child: Text(
              '다시 연결하기',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 원하는 border radius 설정
                side: BorderSide(
                    color: Color(0xff2e2288), width: 2), // 테두리 스타일 설정
              ),
              minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 45),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              '나중에 연결하기',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2e2288)),
            )),
      ],
    ),
  );
}
