import 'package:dna/hospital/webViewPage.dart';
import 'package:flutter/material.dart';

class hospitalPage extends StatefulWidget {
  const hospitalPage({super.key});

  @override
  State<hospitalPage> createState() => _hospitalPageState();
}

class _hospitalPageState extends State<hospitalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height*0.9,
          padding: EdgeInsets.only(top: 20),
          child: WebViewPage()),
    );
  }
}
