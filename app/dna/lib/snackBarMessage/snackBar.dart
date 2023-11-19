import 'package:flutter/material.dart';

void showSnackBar(context, String msg, int sec) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    duration: Duration(seconds: sec),
  ));
}
