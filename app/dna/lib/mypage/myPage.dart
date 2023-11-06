import 'package:flutter/material.dart';

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  State<myPage> createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('image/face.jpg'),
              Text('닉네임'),
              Container(
                child: Column(
                  children: [
                    Text('보호자 정보'),
                    Text('프로필 사진과 이름은 다른 사람이 볼 수 있습니다.'),
                    Table(
                      border: TableBorder.all(),
                      columnWidths: {
                        0: FixedColumnWidth(100),
                        1: FixedColumnWidth(20),
                        2: FixedColumnWidth(20),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
