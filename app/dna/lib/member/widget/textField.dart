import 'package:flutter/material.dart';

textField (Con, String idpw){
  return Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12))
    ),
    child: TextField(
      style: TextStyle(fontSize: 20),
      controller: Con,
      decoration: InputDecoration(
        hintText: idpw,
        border: InputBorder.none,
      ),
    ),
  );
}

textFieldMaxLength (Con, String idpw, int max){
  return Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12))
    ),
    child: TextField(
      maxLength: max,
      buildCounter: (BuildContext context, {required int currentLength, required bool isFocused, required int? maxLength}) {
        return ; // 아무 내용도 반환하지 않음
      },
      style: TextStyle(fontSize: 20),
      controller: Con,
      decoration: InputDecoration(
        hintText: idpw,
        border: InputBorder.none,
      ),
    ),
  );
}