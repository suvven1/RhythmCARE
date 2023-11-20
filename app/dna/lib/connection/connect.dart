import 'package:dna/connection/widget/connect_step_2.dart';
import 'package:flutter/material.dart';

import 'widget/connect_step_1.dart';
import 'widget/connect_step_3.dart';
import 'widget/connect_step_4.dart';

class connectDialog extends StatefulWidget {
  // const badgeDetailDialog({super.key});
  connectDialog({Key? key})
      : super(key: key);

  @override
  State<connectDialog> createState() => _connectDialogState();
}

class _connectDialogState extends State<connectDialog> {
  int _Step = 1;

  void setStep(int step){
    setState(() {
      if(step == 1){
        _Step = 1;
      }else if(step == 2){
        _Step = 2;
        // delayConnect();
      }else if(step == 3){
        _Step = 3;
      }else{
        _Step = 4;
      }
    });
  }

  void delayConnect(){
    Future.delayed(Duration(seconds: 8), () {
      setState(() {
        _Step = 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        backgroundColor: Colors.grey[200],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,15,0,30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('image/logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,),
                SizedBox(height: 10,),
                if( _Step == 1)connect_step_1(context, setStep),
                if( _Step == 2)connect_step_2(context, setStep),
                if( _Step == 3)connect_step_3(context, setStep),
                if( _Step == 4)connect_step_4(context, setStep),
              ],
            ),
          ),
        ));
  }
}
