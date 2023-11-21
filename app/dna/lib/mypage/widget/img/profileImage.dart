import 'dart:typed_data';

import 'package:dna/mypage/widget/img/profileImageDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';

profileImage(context, imageData, getUserData) {
  return TextButton(
    onPressed: () {
      Get.dialog(changeImgDialog()).then((value) {
        if (value) getUserData();

      });
    },
    style: TextButton.styleFrom(
      iconColor: Colors.grey,
      padding: EdgeInsets.zero,
    ),
    child: Stack(clipBehavior: Clip.none, children: [
      ClipOval(
          child: imageData.isNotEmpty
              ? Image.memory(
                  Uint8List.fromList(imageData),
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
