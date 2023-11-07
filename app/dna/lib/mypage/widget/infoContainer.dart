import 'package:dna/mypage/widget/badgeList.dart';
import 'package:dna/mypage/widget/infoGuard.dart';
import 'package:dna/mypage/widget/infoUser.dart';
import 'package:flutter/material.dart';

import '../../widget/sizeBox.dart';

infoContainer(Map infomationGuard, Map informationUser) {
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("회원 탈퇴"),
            Text('탈퇴 후 복구할 수 없습니다. 신중하게 결정해주세요.'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('회원탈퇴'),
                ElevatedButton(onPressed: (){}, child: Text('탈퇴하기'), style: ButtonStyle(

                ),)
              ],
            )
          ],
        )
      ],
    ),
  );
}