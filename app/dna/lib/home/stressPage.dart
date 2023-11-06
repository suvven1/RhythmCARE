import 'package:flutter/material.dart';

class stressPage extends StatefulWidget {
  const stressPage({super.key});

  @override
  State<stressPage> createState() => _stressPageState();
}

class _stressPageState extends State<stressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('stress'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('스트레스 상세페이지'),
        ),
      ),
    );
  }
}
