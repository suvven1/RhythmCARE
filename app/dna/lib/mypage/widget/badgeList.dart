import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../GetMyPageController.dart';

badgeList() {
  MypageController userData = Get.put(MypageController());
  List<String> badgeData = [];
  List<dynamic> badgeImg = [];
  List<String> badgeName = [];
  if (userData.userData["badgeData"] != null) {
    badgeData = List<String>.from(userData.userData["badgeData"]);
    for(int i = badgeData.length; i < 20; i++){
      badgeData.add("s");
    }
    print("제발좀 : ${badgeData}");
  }
  for (int i = 0; i < 20; i++) {
    if (i < 10) {
      if (badgeData.contains("w${i + 1}")) {
        badgeImg.add("badge${i + 1}");
        if (i == 0) {
          badgeName.add("안녕잔디");
        } else if (i == 1) {
          badgeName.add("반갑잔디");
        } else if (i == 2) {
          badgeName.add("고맙잔디");
        } else if (i == 3) {
          badgeName.add("멋잔디");
        } else if (i == 4) {
          badgeName.add("예쁘잔디");
        } else if (i == 5) {
          badgeName.add("초록잔디");
        } else if (i == 6) {
          badgeName.add("첫걸음");
        } else if (i == 7) {
          badgeName.add("발걸음");
        } else if (i == 8) {
          badgeName.add("활개걸음");
        } else if (i == 9) {
          badgeName.add("황소걸음");
        }
      } else {
        badgeImg.add("unknown");
        badgeName.add("????");
      }
    } else if (i < 15) {
      if (badgeData.contains("s${i - 9}")) {
        badgeImg.add("badge${i + 1}");
        if (i == 10) {
          badgeName.add("안녕스트레스");
        } else if (i == 11) {
          badgeName.add("관리대상");
        } else if (i == 12) {
          badgeName.add("지킴이");
        } else if (i == 13) {
          badgeName.add("롤러코스터");
        } else if (i == 14) {
          badgeName.add("평온의폭발");
        }
      } else {
        badgeImg.add("unknown");
        badgeName.add("????");
      }
    } else if (i < 20) {

      if (badgeData.contains("t${i - 14}")) {
        badgeImg.add("badge${i + 1}");
        if (i == 15) {
          badgeName.add("안녕피로도");
        } else if (i == 16) {
          badgeName.add("관리대상");
        } else if (i == 17) {
          badgeName.add("지킴이");
        } else if (i == 18) {
          badgeName.add("롤러코스터");
        } else if (i == 19) {
          badgeName.add("평온의폭발");
        }
      } else {
        badgeImg.add("unknown");
        badgeName.add("????");
      }
    }
  }
print(badgeName);
  return Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      ...List.generate(
          5,
          (propsIndex) => TableRow(
                  children: List.generate(
                4,
                (index) => Container(
                  height: 80,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset(
                          'image/badge/${badgeImg[index + propsIndex * 4]}.png',
                          height: 60),
                      Text(
                        badgeName[index + propsIndex * 4],
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )))
    ],
  );
}
