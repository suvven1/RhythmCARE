import 'package:dna/home/widget/oneDayStress.dart';
import 'package:dna/home/widget/oneWeekStress.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';

class stressPage extends StatelessWidget {
  const stressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 스트레스'),
        backgroundColor: Color(0xff2e2288),
      ),
      body: SafeArea(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              children: [
                oneDayStress(),
                SizeBoxH30,
                horisonLine,
                SizeBoxH30,
                oneWeekStress(),
              ],
            ),
          )
      ),
    );
  }
}
