import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

import 'package:dna/blog/communityView.dart';
import 'package:dna/blog/communityWrite.dart';
import 'package:dna/controller/GetMyPageController.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/GetBlogController.dart';
import '../../url.dart';

class postContainer extends StatefulWidget {
  const postContainer({Key? key, required this.dataDB}) : super(key: key);
  final Map<String, dynamic> dataDB;

  @override
  State<postContainer> createState() => _postContainerState();
}

class _postContainerState extends State<postContainer> {
  BlogController blog = Get.put(BlogController());

  late bool likeBool = false;
  late int likeCnt = widget.dataDB["bd_likes"];

  @override
  void initState() {
    super.initState();
    fetchData();

  }
  void fetchData() async {
    int likeResult = -1;
    likeResult = await blog.getIsLiked(widget.dataDB["bd_idx"]);
    // 데이터를 받아오는 비동기 함수 (예: API 호출 등)
    setState(() {
      if(likeResult != 0){
        likeBool = true;
        likeCnt = likeResult;
      }else{
        likeBool = false;
        likeCnt = likeResult;
      }
    });
  }

  TextStyle textStyle = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Get.to(communityView(dataDB: widget.dataDB, detailData: detailData,));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return communityView(dataDB: widget.dataDB, isLike: likeBool);
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
                  'no. ${widget.dataDB["bd_idx"]}',
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
                        '$likeCnt',
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
                      child: Text(
                          '${widget.dataDB["bd_views"]}', style: textStyle),
                    ),
                  ],
                ),
              ],
            ),
            SizeBoxH20,
            Row(
              children: [
                ClipOval(
                  child: widget.dataDB["mem_profile_img"] != null
                      ? Image.memory(
                    Uint8List.fromList(List<int>.from(
                        widget.dataDB["mem_profile_img"]["data"])),
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
                      widget.dataDB["mem_nick"],
                      style: textStyle,
                    ),
                    Text(
                      widget.dataDB["created_at"].split("T")[0],
                      style: textStyle,
                    ),
                  ],
                )
              ],
            ),
            SizeBoxH20,
            Text(
              widget.dataDB["bd_title"],
              style: textStyle,
            ),
            SizeBoxH30
          ],
        ),
      ),
    );
  }
}