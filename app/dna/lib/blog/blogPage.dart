import 'package:flutter/material.dart';

import '../snackBarMessage/snackBar.dart';

class blogPage extends StatefulWidget {
  const blogPage({super.key});

  @override
  State<blogPage> createState() => _blogPageState();
}

class _blogPageState extends State<blogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              showSnackBar(context, "화면새로고침 완료", 2);
            });
          },
          child: Center(child: Text('건강 블로그입니다.'))),
    );
  }
}
