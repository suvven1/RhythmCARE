import 'package:dna/connection/connect.dart';
import 'package:dna/controller/GetConnectionController.dart';
import 'package:dna/controller/GetMyPageController.dart';
import 'package:dna/mypage/widget/infomation/pwChangeDialog.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';


infoDevice() {
  ConnectionController connect = Get.put(ConnectionController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "기기 정보",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(
        "연결된 기기를 확인할 수 있습니다.",
        style: TextStyle(fontSize: 15, color: Colors.grey),
      ),
      SizeBoxH10,
      horisonLine,
      Table(
        border: TableBorder.symmetric(inside: BorderSide()),
        columnWidths: {1: FlexColumnWidth(2)},
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            Center(
                child: Text(
                  '연결된 기기',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(()=>
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${connect.connectedDeviceName.value}"),
                  ),
                ),
                Obx(()=>
                   ElevatedButton(
                    onPressed: () {
                      if(connect.connectedDeviceName.value == "연결된 기기 없음"){
                        Get.dialog(connectDialog());
                      }else{
                        connect.disconnect();
                      }

                    },
                    child: connect.connectedDeviceName.value == "연결된 기기 없음" ?
                    Text('연결하기',
                      style: TextStyle(color: Colors.black),):
                    Text('해제하기',
                      style: TextStyle(color: Colors.red),)
                    ,
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side:  connect.connectedDeviceName.value == "연결된 기기 없음" ?
                          BorderSide(color: Colors.black):
                          BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(7),
                        )),
                  ),
                )
              ],
            )
          ])
        ],
      ),
      horisonLine,
    ],
  );
}
