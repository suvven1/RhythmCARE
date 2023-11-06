import 'package:flutter/material.dart';

grassTable<Widget>(List list) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(15),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          ...List.generate(
              5,
              (propsIndex) => TableRow(children: List.generate(
                7,
                    (index) => Container(
                  height: 40,
                  margin: EdgeInsets.all(3),
                  color: list[index + propsIndex * 7],
                  ),
                ),
              )
              )
        ],
      ),
    ),
  );
}
