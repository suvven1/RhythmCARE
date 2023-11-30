import 'dart:convert';

import 'package:dna/blog/blogPage.dart';
import 'package:dna/blog/widget/comment.dart';
import 'package:dna/blog/widget/commentWrite.dart';

import 'package:dna/controller/GetMyPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../controller/GetBlogController.dart';
import '../url.dart';
import '../widget/sizeBox.dart';

class communityView extends StatefulWidget {
  const communityView({Key? key, required this.dataDB, required this.isLike})
      : super(key: key);
  final Map<String, dynamic> dataDB;
  final bool isLike;

  @override
  State<communityView> createState() => _communityViewState();
}

class _communityViewState extends State<communityView> {

  BlogController blog = Get.put(BlogController());
  late bool likeBool;

  // 현재 뷰어가 작성자인가?
  late bool isWriter;
  TextStyle titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  TextStyle contextStyle = TextStyle(fontSize: 20);

  @override
  void initState() {
    super.initState();
    fetchData();
    likeBool = widget.isLike;
    isWriter = blog.id == widget.dataDB["mem_id"];
  }

  void fetchData() async {
    blog.commentLists = (await blog.getCommentData(widget.dataDB["bd_idx"]))!;
  }

  FocusNode textFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Obx(()=>
            ListView(
              children: [
                Column(
                  children: [
                    SizeBoxH40,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        !isWriter
                            ? SizedBox()
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    blog.deleteBoard(
                                        widget.dataDB["bd_idx"], context);
                                  });
                                },
                                child: Text(
                                  '삭제',
                                  style: TextStyle(fontSize: 17),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffD95051)),
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            blog.goToMenu(context);
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
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: -widget.dataDB["mem_nick"].length + 18,
                            child: Text(
                              widget.dataDB["bd_title"],
                              style: titleStyle,
                            ),
                          ),
                          Expanded(
                            flex: widget.dataDB["mem_nick"].length,
                            child: Text(
                              widget.dataDB["mem_nick"],
                              style: titleStyle,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                    horisonLine,
                    SizeBoxH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // 게시글 작성 날짜
                          widget.dataDB["created_at"].split("T")[0],
                          style: contextStyle,
                        ),
                        Text(
                          // 조회수
                          '조회수',
                          style: contextStyle,
                        ),
                      ],
                    ),
                    SizeBoxH20,
                    Container(
                      width: double.infinity,
                      child: Text(
                        widget.dataDB["bd_content"],
                        style: contextStyle,
                      ),
                    ),
                    SizeBoxH30,
                    TextButton(
                      onPressed: () {
                        setState(() {
                          likeBool = !likeBool;
                          if (likeBool) {
                            blog.likesAdd(widget.dataDB["bd_idx"]);
                            widget.dataDB["bd_likes"]++;
                          } else {
                            blog.likesPop(widget.dataDB["bd_idx"]);
                            widget.dataDB["bd_likes"]--;
                          }
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
                          '댓글 ${blog.commentLists.length}',
                          style: titleStyle,
                        ),
                      ],
                    ),
                    SizeBoxH20,
                    Column(
                      children: List.generate(blog.commentLists.length,
                          (index) => comment(index: index)),
                    ),
                    commentWrite(bdIdx: widget.dataDB["bd_idx"]),
                    SizeBoxH40
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}