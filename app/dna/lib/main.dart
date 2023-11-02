import 'package:dna/join2Page.dart';
import 'package:dna/splash.dart';
import 'package:flutter/material.dart';
import 'findPage.dart';
import 'loginPage.dart';
import 'joinPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/login' : (_) => loginPage(),
        '/join' : (_) => joinPage(),
        '/join2' : (_) => join2Page(),
        '/find' : (_) => findPage(),
      },
      home: splash(),
    );
  }
}





