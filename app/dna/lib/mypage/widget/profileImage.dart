import 'package:flutter/material.dart';

profileImage (BuildContext context, String imageName){
  return Stack(clipBehavior: Clip.none, children: [
    ClipOval(
      child: Image.asset(
        'image/${imageName}',
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.width * 0.35,
      ),
    ),
  ]);
}