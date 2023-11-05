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
      body: Center(child: Text('건강 블로그입니다.')),
    );
  }
}
