import 'package:dna/home/widget/grassTable.dart';
import 'package:flutter/material.dart';

grass<Widget>(List list) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('걸음 수 잔디밭'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('오늘의 걸음 수에 따라 잔디를 채울 수 있어요'),
              Text('6000보 이상은 연한 잔디,'),
              Text('10000보 이상은 진한 잔디가 채워져요!')
            ],
          ),
          Text('6750걸음')
        ],
      ),
      grassTable(list),
    ],
  );
}
