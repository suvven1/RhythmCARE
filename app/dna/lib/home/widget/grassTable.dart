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
                  height: 39,
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: list[index + propsIndex * 7],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  ),
                ),
              )
              )
        ],
      ),
    ),
  );
}
