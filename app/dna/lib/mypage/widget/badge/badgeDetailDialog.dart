import 'dart:async';

import 'package:flutter/material.dart';

class badgeDetailDialog extends StatefulWidget {
  // const badgeDetailDialog({super.key});
  badgeDetailDialog({Key? key, required this.badgeImg, required this.badgeName})
      : super(key: key);

  final String badgeImg;
  final String badgeName;

  @override
  State<badgeDetailDialog> createState() => _badgeDetailDialogState();
}

class _badgeDetailDialogState extends State<badgeDetailDialog> {
  Color _color = Colors.white;
  bool _isMounted = false; // 추가: mounted 상태를 추적하기 위한 변수

  void chageColor() async {

    // 주기적으로 변수 값을 바꾸기 위한 함수 호출
    Timer.periodic(Duration(seconds: 2), (timer) async {
      if (_isMounted) {
        setState(() {
          if (_color == Colors.white) {
            // _color =  Color(0xff1b3362);
            _color =  Colors.black;
          }else{
            _color =  Colors.white;
          }
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isMounted = true; // 추가: initState에서 mounted 상태를 true로 설정
    chageColor();
  }

  @override
  void dispose() {
    _isMounted = false; // 추가: dispose에서 mounted 상태를 false로 설정
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        backgroundColor: Color(0xff1b3362),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15,30,15,15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.badgeName,
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20,),
                AnimatedContainer(
                  padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: RadialGradient(
                        colors: [
                          _color,
                          Color(0xff1b3362),
                        ],
                        center: Alignment(0,0),
                        radius: 0.5
                      ),
                    ),
                    duration: Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    child: Image.asset(widget.badgeImg, height: 200)
                ),
                SizedBox(height: 20,),
                Container(
                  height: 100,
                  child: Text(
                    "뱃지 획득 조건 부분",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
