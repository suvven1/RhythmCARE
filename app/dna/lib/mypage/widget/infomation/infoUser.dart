import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';

infoUser(Map informationUser) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "기기 사용자 정보",
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
      ),
      SizeBoxH10,
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
                  child: Center(child: Text('${informationUser.keys.toList()[index]}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
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
