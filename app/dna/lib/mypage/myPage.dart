import 'package:flutter/material.dart';

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  State<myPage> createState() => _myPageState();
}

class _myPageState extends State<myPage> {

  // 대표 이미지 이름
  String imageName = "face.jpg";
  String nickName = "닉네임";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('image/${imageName}'),
              Text('$nickName'),

            ],
          ),
        ),
      ),
    );
  }
}
