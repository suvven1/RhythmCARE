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

  // Test용 더미데이터 2
  List<List<dynamic>> detailData = List.generate(150, (index) => [
    index~/3,
    index%3,
    '${index~/3}번 게시글 ${index%3}번 댓글 내용입니다.',
    52,
    false,
    DateTime.now().subtract(Duration(days: index~/3)),
    'Nick${index%3}',
    /*
    0 : 글 번호
    1 : 댓글 번호
    2 : 댓글 내용
    3 : 댓글 공감 수
    4 : 댓글 작성일자
    5 : 댓글 작성자 닉네임
    */
  ]);

  late int postNum;
  late int likeNum;
  late bool likeBool;
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
    likeBool = widget.dataDB[2];
    commentNum = widget.dataDB[3];
    writerImage = List<int>.from(widget.dataDB[4]);
    writerNick = widget.dataDB[5];
    date = widget.dataDB[6].toString().split(' ')[0];
    title = widget.dataDB[7];
  }

  TextStyle textStyle = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
      return TextButton(
        onPressed: (){
          // Get.to(communityView(dataDB: widget.dataDB, detailData: detailData,));
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return communityView(dataDB: widget.dataDB, detailData: detailData,);
          },));
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
                        likeBool
                            ? 'image/trueLike_icon.png'
                            : 'image/falseLike_icon.png',
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
                        'image/comment_icon.png',
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
