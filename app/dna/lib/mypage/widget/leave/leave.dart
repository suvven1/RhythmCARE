import 'dart:convert';

import 'package:dna/member/loginPage.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../controller/GetMyPageController.dart';
import '../../myPage.dart';
import 'package:dna/mypage/widget/leave/leaveModal.dart';

leave(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("계정 탈퇴", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Text('탈퇴 후 복구할 수 없습니다. 신중하게 결정해주세요.', style: TextStyle(color: Colors.grey),),
      SizeBoxH10,
      horisonLine,
      Table(
        border: TableBorder.symmetric(inside: BorderSide()),
        columnWidths: {1: FlexColumnWidth(2)},
        children: [
          TableRow(
            children: [
              Center(child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text('계정 탈퇴', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
              )),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showLeaveDialog(context);
                  },
                  child: Text('탈퇴하기'),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.red),
                      elevation: 0,
                  ),
                ),
              )
            ]
          )
        ],
      ),
      horisonLine,
    ],
  );
}
