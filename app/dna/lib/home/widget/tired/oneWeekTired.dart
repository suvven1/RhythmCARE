import 'package:dna/home/widget/tired/oneWeekTiredChart.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';

class oneWeekTired extends StatelessWidget {
  const oneWeekTired({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('한 주 피로도',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizeBoxH20,
        oneWeekTiredChart(),
      ],
    );
  }
}
