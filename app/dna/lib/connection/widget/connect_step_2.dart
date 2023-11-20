import 'package:dna/controller/GetConnectionController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'connect_list.dart';

connect_step_2(context, setStep) {
  ConnectionController connect = Get.put(ConnectionController());
  connect.startScan();
  return Container(
    height: 340,
    child: Column(
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            height: MediaQuery.of(context).size.width * 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Obx(() => connect.isWidgetLoding.value ?
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("기기 검색중..."),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(),
              ],
            )
                : connect_list())),
        SizedBox(
          height: 24,
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
                minimumSize:
                Size(MediaQuery.of(context).size.width * 0.5, 45)),
            onPressed: () {
              setStep(3);
            },
            child: Text(
              '장치 다시 검색하기',
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
                borderRadius:
                BorderRadius.circular(10), // 원하는 border radius 설정
                side: BorderSide(
                    color: Color(0xff2e2288), width: 2), // 테두리 스타일 설정
              ),
              minimumSize:
              Size(MediaQuery.of(context).size.width * 0.5, 45),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              '취소',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2e2288)),
            )),
      ],
    ),
  );
}