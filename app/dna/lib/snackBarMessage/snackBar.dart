import 'package:flutter/material.dart';

void showSnackBar(context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    duration: const Duration(seconds: 2),
  ));
}
