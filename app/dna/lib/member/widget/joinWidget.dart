import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../joinPage.dart';

joinWidget (){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        '아직 계정이 없으신가요?',
        style: TextStyle(color: Colors.grey[600]),
      ),
      TextButton(
        onPressed: () {
          Get.to(()=>joinPage());
        },
        child: Text('회원가입',
            style: TextStyle(
                color: Color(0xff2e2288),
                fontWeight: FontWeight.bold)),
      ),
    ],
  );
}