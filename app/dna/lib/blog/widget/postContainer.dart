import 'dart:typed_data';

import 'package:dna/blog/communityView.dart';
import 'package:dna/blog/communityWrite.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class postContainer extends StatefulWidget {
  const postContainer({Key? key, required this.dataDB}) : super(key: key);
  final List<dynamic> dataDB;

  @override
  State<postContainer> createState() => _postContainerState();
}

class _postContainerState extends State<postContainer> {
  late int postNum;
  late int likeNum;
  late int commentNum;
  late List<int> writerImage;
  late String writerNick;
  late String date;
  late String title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postNum = widget.dataDB[0];
    likeNum = widget.dataDB[1];
    commentNum = widget.dataDB[2];
    writerImage = List<int>.from(widget.dataDB[3]);
    writerNick = widget.dataDB[4];
    date = widget.dataDB[5];
    title = widget.dataDB[6];
  }

  TextStyle textStyle = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
      return TextButton(
        onPressed: (){
          Get.to(communityView());
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: Colors.black,
        ),
        child: Container(
          decoration: BoxDecoration(border: Border(bottom: BorderSide())),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeBoxH20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'no. $postNum',
                    style: textStyle,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'image/heart_good.png',
                        height: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(
                          '$likeNum',
                          style: textStyle,
                        ),
                      ),
                      Image.asset(
                        'image/navigationBarIcon/icon_db.png',
                        height: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 40,
                        child: Text('$commentNum', style: textStyle),
                      ),
                    ],
                  ),
                ],
              ),
              SizeBoxH20,
              Row(
                children: [
                  ClipOval(
                    child: writerImage.isNotEmpty
                        ? Image.memory(
                      Uint8List.fromList(writerImage),
                      width: 50,
                      height: 50,
                    )
                        : Image.asset(
                      'image/User.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        writerNick,
                        style: textStyle,
                      ),
                      Text(
                        date,
                        style: textStyle,
                      ),
                    ],
                  )
                ],
              ),
              SizeBoxH20,
              Text(
                title,
                style: textStyle,
              ),
              SizeBoxH30
            ],
          ),
        ),
      );
  }
}
