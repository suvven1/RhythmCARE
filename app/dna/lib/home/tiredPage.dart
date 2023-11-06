import 'package:flutter/material.dart';

class tiredPage extends StatefulWidget {
  const tiredPage({super.key});

  @override
  State<tiredPage> createState() => _tiredPageState();
}

class _tiredPageState extends State<tiredPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tired'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('피로도 상세페이지'),
        ),
      ),
    );
  }
}
