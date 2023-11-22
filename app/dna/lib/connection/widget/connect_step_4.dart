import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/GetConnectionController.dart';
import '../../toastMessage/toast.dart';


connect_step_4(context, setStep) {
  void checkBlue(context) async {
// 블루투스 활성화 여부 확인
    bool isBluetoothEnabled = await FlutterBlue.instance.isOn;
    if (!isBluetoothEnabled) {
// 블루투스가 비활성화된 경우 활성화 요청
      showToast('블루투스 연결필요');
      setStep(4);
    } else {
      setStep(2);
    }
  }
  return Container(
    height: 340,
    child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "블루투스를 활성화 해주세요.",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff2e2288),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: MediaQuery.of(context).size.width * 0.43,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Image.asset('image/bluetoothIcon/blueConnectFali.png',
            width: MediaQuery.of(context).size.width * 0.5,)
        ),
        SizedBox(
          height: 10,
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
              checkBlue(context);
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
