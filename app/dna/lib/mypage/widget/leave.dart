import 'package:flutter/material.dart';

leave (){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("회원 탈퇴"),
      Text('탈퇴 후 복구할 수 없습니다. 신중하게 결정해주세요.'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('회원탈퇴'),
          ElevatedButton(onPressed: (){}, child: Text('탈퇴하기'), style: ButtonStyle(
          ),)
        ],
      )
    ],
  );
}