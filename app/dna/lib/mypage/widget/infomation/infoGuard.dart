import 'package:dna/controller/GetMyPageController.dart';
import 'package:dna/mypage/widget/infomation/pwChangeDialog.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


infoGuard() {
  MypageController mypage = Get.put(MypageController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "보호자 정보",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(
        "프로필 사진과 이름은 다른 사람이 볼 수 있습니다.",
        style: TextStyle(fontSize: 15, color: Colors.grey),
      ),
      SizeBoxH10,
      horisonLine,
      Table(
        border: TableBorder.symmetric(inside: BorderSide()),
        columnWidths: {1: FlexColumnWidth(2)},
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          ...List.generate(
              4,
              (index) => TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        '${mypage.infomationGuard.value.keys.toList()[index]}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${mypage.infomationGuard.value.values.toList()[index]}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ])),
          TableRow(children: [
            Center(
                child: Text(
              '비밀번호',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('********'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.dialog(
                      pwChangeDialog()
                    );
                  },
                  child: Text(
                    '변경하기',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(7),
                      )),
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
