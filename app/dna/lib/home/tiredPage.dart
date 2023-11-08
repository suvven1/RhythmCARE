import 'package:dna/home/widget/oneDayTired.dart';
import 'package:dna/home/widget/oneWeekTired.dart';
import 'package:flutter/material.dart';

import '../widget/sizeBox.dart';

class tiredPage extends StatelessWidget {
  const tiredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 피로도'),
        backgroundColor: Color(0xff2e2288),
      ),
      body: SafeArea(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              children: [
                oneDayTired(),
                SizeBoxH30,
                horisonLine,
                SizeBoxH30,
                oneWeekTired(),
              ],
            ),
          )
      ),
    );
  }
}
