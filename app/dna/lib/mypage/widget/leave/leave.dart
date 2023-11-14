import 'dart:convert';

import 'package:dna/member/loginPage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../GetMyPageController.dart';
import '../../myPage.dart';
import 'package:dna/mypage/widget/leave/leaveModal.dart';

leave(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("회원 탈퇴"),
      Text('탈퇴 후 복구할 수 없습니다. 신중하게 결정해주세요.'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('회원탈퇴'),
          ElevatedButton(
            onPressed: () {
              showPopUp(context);
            },
            child: Text('탈퇴하기'),
            style: ButtonStyle(),
          )
        ],
      )
    ],
  );
}
