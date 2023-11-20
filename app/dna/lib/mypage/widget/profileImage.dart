import 'dart:typed_data';

import 'package:flutter/material.dart';

profileImage(BuildContext context, List<dynamic> imageData) {
  List<int> img = List<int>.from(imageData);
  return TextButton(
    onPressed: (){},
    style: TextButton.styleFrom(
      iconColor: Colors.grey,
      padding: EdgeInsets.zero,
    ),
    child: Stack(clipBehavior: Clip.none, children: [
      ClipOval(
          child: imageData.isNotEmpty
              ? Image.memory(
                  Uint8List.fromList(img),
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.width * 0.35,
                )
              : Image.asset(
                  'image/User.png',
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.width * 0.35,
                )),
      Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.25,
            left: MediaQuery.of(context).size.width * 0.24),
        child: ClipOval(
          child: Container(
            color: Colors.white,
            child: Icon(
              Icons.change_circle,
              size: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
        ),
      )
    ]),
  );
}
