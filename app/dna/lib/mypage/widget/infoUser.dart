import 'package:flutter/material.dart';

infoUser(Map informationUser) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "기기 사용자 정보",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          ...List.generate(
              3,
                  (index) => TableRow(children: [
                Text('${informationUser.keys.toList()[index]}'),
                Text('${informationUser.values.toList()[index]}'),
              ])),
        ],
      ),
    ],
  );
}
