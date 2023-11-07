import 'package:flutter/material.dart';

profileNick (String nickName){
  return Text(
    '$nickName',
    style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
    ),
  );
}