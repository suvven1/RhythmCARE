import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/sizeBox.dart';

class communityView extends StatefulWidget {
  const communityView({Key? key, required this.dataDB}) : super(key: key);
  final List<dynamic> dataDB;

  @override
  State<communityView> createState() => _communityViewState();
}

class _communityViewState extends State<communityView> {

  late int postNum;
  late int likeNum;
  late int commentNum;
  late String writerNick;
  late String date;
  late String title;
  late String contexts;

  TextEditingController commentCon = TextEditingController();

  TextStyle titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  TextStyle contextStyle = TextStyle(fontSize: 20);

  @override
  void initState() {
    super.initState();
    postNum = widget.dataDB[0];
    likeNum = widget.dataDB[1];
    commentNum = widget.dataDB[2];
    writerNick = widget.dataDB[4];
    date = widget.dataDB[5];
    title = widget.dataDB[6];
    contexts = widget.dataDB[7];
    print(1);
  }

  @override
  Widget build(BuildContext context) {
    print(2);
    return Scaffold(
      appBar: AppBar(
        title: Text('상세 페이지'),
        backgroundColor: Color(0xff2e2288),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.03,
              bottom: MediaQuery.of(context).size.height * 0.03),
          child: ListView(
            children: [
              Column(
                children: [
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
                        Text(title, style: titleStyle,),
                        Text(writerNick, style: titleStyle,),
                      ],
                    ),
                  ),
                  horisonLine,
                  SizeBoxH10,
                  Row(
                    children: [
                      Text(date, style: contextStyle,),
                    ],
                  ),
                  SizeBoxH20,
                  Text(contexts, style: contextStyle,),
                  SizeBoxH30,
                  Image.asset('image/heart_good.png', height: 50,),
                  Text('$likeNum', style: contextStyle,),
                  SizeBoxH20,
                  horisonLine,
                  SizeBoxH30,
                  Row(
                    children: [
                      Text('댓글 $commentNum', style: titleStyle,),
                    ],
                  ),
                  SizeBoxH40,
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
