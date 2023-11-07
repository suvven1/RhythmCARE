import 'package:flutter/material.dart';

textField (Con, String idpw){
  return Container(
    padding: EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      border: Border.all(),
      borderRadius: BorderRadius.all(Radius.circular(12))
    ),
    child: TextField(
      controller: Con,
      decoration: InputDecoration(
        hintText: idpw,
        border: InputBorder.none,
      ),
    ),
  );
}