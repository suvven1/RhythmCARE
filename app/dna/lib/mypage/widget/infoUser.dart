import 'package:flutter/material.dart';

infoUser (Map informationUser){
  return Column(
    children: [Text("기기 사용자 정보"),
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
      ),],
  );
}