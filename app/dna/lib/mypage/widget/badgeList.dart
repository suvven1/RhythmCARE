import 'package:flutter/material.dart';

badgeList (){
  return Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      ...List.generate(
          3,
              (propsIndex) => TableRow(
              children: List.generate(
                4,
                    (index) => Container(
                  height: 80,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Text(
                        '${index + propsIndex * 4}번 뱃지',
                        style: TextStyle(fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )))
    ],
  );
}