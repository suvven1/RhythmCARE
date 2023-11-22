import 'package:flutter/material.dart';

class communityView extends StatefulWidget {
  const communityView({super.key});

  @override
  State<communityView> createState() => _communityViewState();
}

class _communityViewState extends State<communityView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글 상세페이지'),
        backgroundColor: Color(0xff2e2288),
      ),
      body: Container(
        child: Center(
          child: Text('글 상세페이지입니다.'),
        ),
      ),

    );
  }
}
