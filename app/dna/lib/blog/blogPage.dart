import 'package:dna/toastMessage/toast.dart';
import 'package:flutter/material.dart';

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
              showToast("화면새로고침 완료");
            });
          },
          child: Center(child: Text('건강 블로그입니다.'))),
    );
  }
}
