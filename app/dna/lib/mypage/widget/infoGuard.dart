import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../GetMyPageController.dart';

infoGuard(Map infomationGuard) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "보호자 정보",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(
        "프로필 사진과 이름은 다른 사람이 볼 수 있습니다.",
        style: TextStyle(color: Colors.grey),
      ),
      Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          ...List.generate(
              4,
                  (index) => TableRow(children: [
                Text('${infomationGuard.keys.toList()[index]}'),
                Text('${infomationGuard.values.toList()[index]}'),
              ])),
          TableRow(children: [
            Text('비밀번호'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('*****'),
                ElevatedButton(onPressed: () {}, child: Text('변경하기'))
              ],
            )
          ])
        ],
      ),
    ],
  );
}
