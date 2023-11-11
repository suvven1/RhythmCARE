import 'dart:typed_data';

import 'package:flutter/material.dart';

profileImage(BuildContext context, List<int> imageData) {
  return Stack(clipBehavior: Clip.none, children: [
  ClipOval(
  child:
  imageData.isNotEmpty ? Image.memory(Uint8List.fromList(imageData),
  width: MediaQuery.of(context).size.width * 0.35,
  height: MediaQuery.of(context).size.width * 0.35,) :
  Image.asset('image/User.png',
  width: MediaQuery.of(context).size.width * 0.35,
  height: MediaQuery.of(context).size.width * 0.35,)
  )
  ,
  ]
  );
}