import 'package:flutter/material.dart';

heartBeat (int heartBeatNum) {
  return Stack(
    children: [
      Image.asset('image/heart.gif'),
      Center(
        heightFactor: 3,
        child: Column(
          children: [
            Text(
              '$heartBeatNum',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 65),
            ),
            Text(
              'bpm',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      )
    ],
  );
}