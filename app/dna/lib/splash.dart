import 'package:flutter/material.dart';
import 'member/loginPage.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _SplashState();
}

class _SplashState extends State<splash> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const loginPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Align(
                  alignment: const Alignment(0.0,-0.15),
                  child: Transform.scale(
                      scale: 0.85,
                      child: Image.asset('image/logo.png')
                  )
              ),
            ),
          )
      ),
    );
  }
}