import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget gridview = GridView.builder(
    itemCount: 10,
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 3,
        mainAxisExtent: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1/1),
    itemBuilder: (BuildContext context, int index) {
      return Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: Colors.blue),
        child: Text('Item : $index'),
      );
    });
