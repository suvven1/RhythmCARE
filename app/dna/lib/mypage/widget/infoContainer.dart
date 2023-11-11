import 'package:dna/mypage/widget/badgeList.dart';
import 'package:dna/mypage/widget/infoGuard.dart';
import 'package:dna/mypage/widget/infoUser.dart';
import 'package:dna/mypage/widget/leave.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widget/sizeBox.dart';
import '../GetMyPageController.dart';

infoContainer(Map infomationGuard, Map informationUser, context) {

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoGuard(infomationGuard),
        SizeBoxH30,
        infoUser(informationUser),
        SizeBoxH30,
        badgeList(),
        SizeBoxH50,
        leave(context),
      ],
    ),
  );
}