import 'package:flutter/material.dart';

class communityWrite extends StatefulWidget {
  const communityWrite({super.key});

  @override
  State<communityWrite> createState() => _communityWriteState();
}

class _communityWriteState extends State<communityWrite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글쓰기'),
        backgroundColor: Color(0xff2e2288),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('글 작성 페이지입니다.'),
          ),
        ),
      ),
    );
  }
}
