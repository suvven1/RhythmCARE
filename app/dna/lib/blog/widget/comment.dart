import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/GetBlogController.dart';

class comment extends StatefulWidget {
  const comment({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> {
  BlogController blog = Get.put(BlogController());
  TextStyle titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  TextStyle contextStyle = TextStyle(fontSize: 20);
  bool cmtLikes = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    bool result = await blog.getIsCmtLiked(blog.commentLists[widget.index]["cmt_idx"]);
    setState(() {
      if(result){
        cmtLikes = true;
      }else{
        cmtLikes = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                blog.commentLists[widget.index]["mem_nick"],
                style: contextStyle,
                maxLines: 1,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    cmtLikes = !cmtLikes;
                    if(cmtLikes){
                      blog.cmtLikesAdd(blog.commentLists[widget.index]["cmt_idx"]);
                      blog.commentLists[widget.index]["cmt_likes"]++;
                    }else{
                      blog.cmtLikesPop(blog.commentLists[widget.index]["cmt_idx"]);
                      blog.commentLists[widget.index]["cmt_likes"]--;
                    }
                  });
                },
                child: Row(
                  children: [
                    Image.asset(
                      cmtLikes
                          ? 'image/trueLike_icon.png'
                          : 'image/falseLike_icon.png',
                      width: 20,
                    ),
                    Text(
                      ' ${blog.commentLists[widget.index]["cmt_likes"]}',
                      style: contextStyle,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                // 댓글 내용
                Text(
                  blog.commentLists[widget.index]["cmt_content"],
                  style: contextStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  // 댓글 입력 날짜
                  blog.commentLists[widget.index]["created_at"].split("T")[0],
                  style: TextStyle(
                      fontSize: 17, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
