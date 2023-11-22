import 'package:dna/mypage/widget/nick/nickDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

profileNick(String nickName, getUserData) {
  return TextButton(
    onPressed: (){
      Get.dialog(
        nickDialog(),
      ).then((value){
        if(value)getUserData();
      });
    },
    style: TextButton.styleFrom(
      foregroundColor: Colors.black
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24,
        ),
        Text(
          '$nickName',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Icon(Icons.edit_note)
      ],
    ),
  );
}
