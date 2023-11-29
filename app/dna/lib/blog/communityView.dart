import 'dart:convert';

import 'package:dna/controller/GetMyPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controller/GetBlogController.dart';
import '../url.dart';
import '../widget/sizeBox.dart';

class communityView extends StatefulWidget {
  const communityView({Key? key, required this.dataDB}) : super(key: key);
  final Map<String, dynamic> dataDB;

  @override
  State<communityView> createState() => _communityViewState();
}

class _communityViewState extends State<communityView> {
  BlogController blog = Get.put(BlogController());
  late bool likeBool;
  late List<String> commentList = [];
  late List<int> commentLike = [];
  late List<bool> commentLikeBool = [];
  late List<String> commentdate = [];
  late List<String> commentNick = [];

  // 현재 뷰어가 작성자인가?
  late bool isWriter;

  TextEditingController commentCon = TextEditingController();
  final MypageController userDataCon = Get.put(MypageController());

  TextStyle titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  TextStyle contextStyle = TextStyle(fontSize: 20);

  @override
  void initState() {
    super.initState();
    fetchData();
    // postNum = widget.dataDB[0];
    // likeNum = widget.dataDB[1];
    likeBool = false;
    // commentNum = widget.dataDB[3];
    // writerNick = widget.dataDB[5];
    // date = widget.dataDB[6].toString().split(' ')[0];
    // title = widget.dataDB[7];
    // contexts = widget.dataDB[8];

    /*
    0 : 글 번호
    1 : 댓글 번호
    2 : 댓글 내용
    3 : 댓글 공감 수
    4 : 댓글 작성일자
    5 : 댓글 작성자 닉네임
    */
    isWriter = userDataCon.nick.value == widget.dataDB["mem_nick"];
  }

  void fetchData() async {
    // 데이터를 받아오는 비동기 함수 (예: API 호출 등)
    blog.commentList = (await getCommentData())!;

    // 데이터가 정상적으로 받아와졌다면 실행
    if (blog.commentList.isNotEmpty) {
      setState(() {
        commentList = List.generate(blog.commentList.length,
            (index) => blog.commentList[index]["cmt_content"]);

        commentLike = List.generate(blog.commentList.length,
            (index) => blog.commentList[index]["cmt_likes"]);

        commentLikeBool =
            List.generate(blog.commentList.length, (index) => false);

        commentdate = List.generate(blog.commentList.length,
            (index) => blog.commentList[index]["created_at"].split("T")[0]);

        commentNick = List.generate(blog.commentList.length,
            (index) => blog.commentList[index]["mem_nick"]);
      });
    }
  }

  Future<RxList<Map<String, dynamic>>?> getCommentData() async {
    String url = "http://${URL.ip}/comment/getComment";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"bd_idx": widget.dataDB["bd_idx"]}));

    var resData = jsonDecode(res.body)["commentData"];

    if (resData != false) {
      RxList<Map<String, dynamic>> commentList =
          RxList<Map<String, dynamic>>.from(resData.toList());
      return commentList;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  SizeBoxH40,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      !isWriter
                          ? SizedBox()
                          : ElevatedButton(
                              onPressed: () {
                                // DB 삭제 여기에 넣으면 됨
                                // Get.back();
                                Navigator.pop(context);
                              },
                              child: Text(
                                '삭제하기',
                                style: TextStyle(fontSize: 17),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffD95051)),
                            ),
                      ElevatedButton(
                        onPressed: () {
                          // Get.back();
                          Navigator.pop(context);
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
                          widget.dataDB["bd_title"],
                          style: titleStyle,
                        ),
                        Text(
                          widget.dataDB["mem_nick"],
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
                        widget.dataDB["created_at"].split("T")[0],
                        style: contextStyle,
                      ),
                    ],
                  ),
                  SizeBoxH20,
                  Text(
                    widget.dataDB["bd_content"],
                    style: contextStyle,
                  ),
                  SizeBoxH30,
                  TextButton(
                    onPressed: () {
                      setState(() {
                        likeBool = !likeBool;
                        likeBool
                            ? widget.dataDB["bd_likes"]++
                            : widget.dataDB["bd_likes"]--;
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
                          '${widget.dataDB["bd_likes"]}',
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
                        '댓글 ${blog.commentList.length}',
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
                                  border: Border(
                                      top: BorderSide(color: Colors.grey))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        commentNick[index],
                                        style: contextStyle,
                                        maxLines: 1,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            commentLikeBool[index] =
                                                !commentLikeBool[index];
                                            commentLikeBool[index]
                                                ? commentLike[index]++
                                                : commentLike[index]--;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              commentLikeBool[index]
                                                  ? 'image/trueLike_icon.png'
                                                  : 'image/falseLike_icon.png',
                                              width: 20,
                                            ),
                                            Text(
                                              ' ${commentLike[index]}',
                                              style: contextStyle,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(commentList[index],
                                              style: contextStyle,
                                              ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            commentdate[index],
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey),
                                          ),
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
