import 'package:dna/mypage/widget/badge/badgeList.dart';
import 'package:dna/mypage/widget/infomation/infoGuard.dart';
import 'package:dna/mypage/widget/infomation/infoUser.dart';
import 'package:dna/mypage/widget/leave/leave.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../widget/sizeBox.dart';
import '../../../controller/GetMyPageController.dart';
import 'infoDevice.dart';

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
        SizeBoxH10,
        infoDevice(),
        SizeBoxH30,
        infoGuard(),
        SizeBoxH30,
        infoUser(),
        SizeBoxH30,
        badgeList(),
        SizeBoxH50,
        leave(context),
        SizeBoxH20,
      ],
    ),
  );
}