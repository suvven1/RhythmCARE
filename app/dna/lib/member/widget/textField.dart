import 'package:flutter/material.dart';

textField (Con, String idpw){
  return Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
        color: Colors.grey[300],
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