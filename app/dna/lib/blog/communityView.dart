import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/sizeBox.dart';

class communityView extends StatefulWidget {
  const communityView(
      {Key? key, required this.dataDB, required this.detailData})
      : super(key: key);
  final List<dynamic> dataDB;
  final List<dynamic> detailData;

  @override
  State<communityView> createState() => _communityViewState();
}

class _communityViewState extends State<communityView> {
  late int postNum;
  late int likeNum;
  late bool likeBool;
  late int commentNum;
  late String writerNick;
  late String date;
  late String title;
  late String contexts;
  late List<String> commentList;
  late List<int> commentLike;
  late List<bool> commentLikeBool;
  late List<String> commentdate;
  late List<String> commentNick;

  TextEditingController commentCon = TextEditingController();

  TextStyle titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  TextStyle contextStyle = TextStyle(fontSize: 20);

  @override
  void initState() {
    super.initState();
    postNum = widget.dataDB[0];
    likeNum = widget.dataDB[1];
    likeBool = widget.dataDB[2];
    commentNum = widget.dataDB[3];
    writerNick = widget.dataDB[5];
    date = widget.dataDB[6].toString().split(' ')[0];
    title = widget.dataDB[7];
    contexts = widget.dataDB[8];
    commentList = List.generate(
        commentNum, (index) => widget.detailData[postNum*3 + index][2]);
    commentLike = List.generate(commentNum, (index) => widget.detailData[postNum*3 + index][3]);
    commentLikeBool = List.generate(commentNum, (index) => widget.detailData[postNum*3 + index][4]);
    commentdate = List.generate(commentNum, (index) => widget.detailData[postNum*3 + index][5].toString().split(' ')[0]);
    commentNick = List.generate(commentNum, (index) => widget.detailData[postNum*3 + index][6]);
    /*
    0 : 글 번호
    1 : 댓글 번호
    2 : 댓글 내용
    3 : 댓글 공감 수
    4 : 댓글 작성일자
    5 : 댓글 작성자 닉네임
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,),
          child: ListView(
            children: [
              Column(
                children: [
                  SizeBoxH40,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          '목록으로',
                          style: TextStyle(fontSize: 17),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff2e2288)),
                      ),
                    ],
                  ),
                  SizeBoxH10,
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Color(0xff2e2288), width: 5))),
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: titleStyle,
                        ),
                        Text(
                          writerNick,
                          style: titleStyle,
                        ),
                      ],
                    ),
                  ),
                  horisonLine,
                  SizeBoxH10,
                  Row(
                    children: [
                      Text(
                        date,
                        style: contextStyle,
                      ),
                    ],
                  ),
                  SizeBoxH20,
                  Text(
                    contexts,
                    style: contextStyle,
                  ),
                  SizeBoxH30,
                  TextButton(
                    onPressed: (){
                      setState(() {
                        likeBool = !likeBool;
                        likeBool ? likeNum++ : likeNum--;
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          likeBool
                              ? 'image/trueLike_icon.png'
                              : 'image/falseLike_icon.png',
                          height: 50,
                        ),
                        Text(
                          '$likeNum',
                          style: contextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizeBoxH20,
                  horisonLine,
                  SizeBoxH30,
                  Row(
                    children: [
                      Text(
                        '댓글 $commentNum',
                        style: titleStyle,
                      ),
                    ],
                  ),
                  SizeBoxH20,
                  Column(
                    children: List.generate(
                        commentList.length,
                        (index) => Container(
                          padding: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(commentNick[index], style: contextStyle, maxLines: 1,),
                                  TextButton(
                                    onPressed: (){
                                      setState(() {
                                        commentLikeBool[index] = !commentLikeBool[index];
                                        commentLikeBool[index] ? commentLike[index]++ : commentLike[index]--;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(commentLikeBool[index] ? 'image/trueLike_icon.png': 'image/falseLike_icon.png', width: 20,),
                                        Text(' ${commentLike[index]}', style: contextStyle, maxLines: 1, ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 15,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(commentList[index], style: contextStyle,),
                                      SizedBox(height: 5,),
                                      Text(commentdate[index], style: TextStyle(fontSize: 17, color: Colors.grey),),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                  horisonLine,
                  SizeBoxH20,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: TextField(
                      controller: commentCon,
                      style: contextStyle,
                      decoration: InputDecoration(
                        hintText: '댓글을 남겨주세요.',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizeBoxH40
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
