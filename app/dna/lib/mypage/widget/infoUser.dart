import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';

infoUser(Map informationUser) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "기기 사용자 정보",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      horisonLine,
      Table(
        border: TableBorder.symmetric(inside: BorderSide()),
        columnWidths: {1: FlexColumnWidth(2)},
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          ...List.generate(
              3,
                  (index) => TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${informationUser.keys.toList()[index]}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${informationUser.values.toList()[index]}'),
                ),
              ])),
        ],
      ),
      horisonLine,
    ],
  );
}
