import 'package:flutter/material.dart';

class oneWeekStress extends StatelessWidget {
  const oneWeekStress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('한 주 스트레스',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Image.asset('image/visualModel_Week.png'),
      ],
    );
  }
}
