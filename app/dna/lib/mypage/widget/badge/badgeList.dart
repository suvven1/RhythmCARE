import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/GetMyPageController.dart';
import 'badgeDetailDialog.dart';

badgeList() {
  MypageController userData = Get.put(MypageController());
  List<String> badgeData = [];
  List<dynamic> badgeImg = [];
  List<String> badgeName = [];
  List<String> badgeText = [];
  badgeData = List<String>.from(userData.badgeData);
  for (int i = badgeData.length; i < 20; i++) {
    badgeData.add("?");
  }
  for (int i = 0; i < 20; i++) {
    if (i < 10) {
      if (badgeData.contains("w${i + 1}")) {
        badgeImg.add("badge${i + 1}");
        if (i == 0) {
          badgeName.add("안녕잔디");
          badgeText.add("걸음수 잔디밭에 처음으로 잔디를 심었어요.");
        } else if (i == 1) {
          badgeName.add("반갑잔디");
          badgeText.add("걸음수 잔디밭에 잔디를 7개 심었어요.");
        } else if (i == 2) {
          badgeName.add("고맙잔디");
          badgeText.add("걸음수 잔디밭에 잔디를 30개 심었어요.");
        } else if (i == 3) {
          badgeName.add("멋잔디");
          badgeText.add("걸음수 잔디밭에 잔디를 연속으로 7개 심었어요.");
        } else if (i == 4) {
          badgeName.add("예쁘잔디");
          badgeText.add("걸음수 잔디밭에 잔디를 연속으로 15개 심었어요.");
        } else if (i == 5) {
          badgeName.add("초록잔디");
          badgeText.add("걸음수 잔디밭에 잔디를 연속으로 30개 심었어요.");
        } else if (i == 6) {
          badgeName.add("첫걸음");
          badgeText.add("첫 5000보를 달성했어요.");
        } else if (i == 7) {
          badgeName.add("발걸음");
          badgeText.add("첫 10000보를 달성했어요.");
        } else if (i == 8) {
          badgeName.add("활개걸음");
          badgeText.add("지금까지 50000보를 걸었어요!");
        } else if (i == 9) {
          badgeName.add("황소걸음");
          badgeText.add("지금까지 200000보를 걸었어요!");
        }
      } else {
        badgeImg.add("unknown");
        badgeName.add("????");
        badgeText.add("걸음수를 늘려 다양한 뱃지를 획득해 보세요.");
      }
    } else if (i < 15) {
      if (badgeData.contains("s${i - 9}")) {
        badgeImg.add("badge${i + 1}");
        if (i == 10) {
          badgeName.add("안녕스트레스");
          badgeText.add("스트레스를 처음으로 측정했어요.");
        } else if (i == 11) {
          badgeName.add("관리대상");
          badgeText.add("스트레스가 지속적으로 높아요. 관리가 필요해요.");
        } else if (i == 12) {
          badgeName.add("지킴이");
          badgeText.add("스트레스가 지속적으로 낮아요. 관리를 잘 하고 있어요.");
        } else if (i == 13) {
          badgeName.add("롤러코스터");
          badgeText.add("스트레스가 풀리셨나요? 지금처럼만 유지해주세요.");
        } else if (i == 14) {
          badgeName.add("평온의폭발");
          badgeText.add("무슨 일이 생기셨나요? 스트레스가 갑자기 높아졌어요.");
        }
      } else {
        badgeImg.add("unknown");
        badgeName.add("????");
        badgeText.add("스트레스 관리를 통해 다양한 뱃지를 획득해 보세요.");
      }
    } else if (i < 20) {
      if (badgeData.contains("t${i - 14}")) {
        badgeImg.add("badge${i + 1}");
        if (i == 15) {
          badgeName.add("안녕피로도");
          badgeText.add("피로도를 처음으로 측정했어요.");
        } else if (i == 16) {
          badgeName.add("관리대상");
          badgeText.add("피로도가 지속적으로 높아요. 관리가 필요해요.");
        } else if (i == 17) {
          badgeName.add("지킴이");
          badgeText.add("피로도가 지속적으로 낮아요. 관리를 잘 하고 있어요.");
        } else if (i == 18) {
          badgeName.add("롤러코스터");
          badgeText.add("피로도가 풀리셨나요? 지금처럼만 유지해주세요.");
        } else if (i == 19) {
          badgeName.add("평온의폭발");
          badgeText.add("너무 무리하지 마세요! 피로도가 갑자기 높아졌어요.");
        }
      } else {
        badgeImg.add("unknown");
        badgeName.add("????");
        badgeText.add("피로도 관리를 통해 다양한 뱃지를 획득해 보세요.");
      }
    }
  }
  return Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      ...List.generate(
          5,
          (propsIndex) => TableRow(
                  children: List.generate(
                4,
                (index) => GestureDetector(
                  onTap: (){
                    Get.dialog(
                        badgeDetailDialog(
                            badgeImg: 'image/badge/${badgeImg[index + propsIndex * 4]}.png',
                            badgeName: badgeName[index + propsIndex * 4],
                            badgeText: badgeText[index + propsIndex * 4]
                        )
                    );
                  },
                  child: Container(
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
                ),
              )))
    ],
  );
}
