import 'package:dna/blog/widget/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/GetBlogController.dart';
import '../../widget/sizeBox.dart';

class commentWrite extends StatefulWidget {
  const commentWrite({Key? key, required this.bdIdx}) : super(key: key);

  final int bdIdx;

  @override
  State<commentWrite> createState() => _commentWriteState();
}

class _commentWriteState extends State<commentWrite> {
  BlogController blog = Get.put(BlogController());
  final FocusNode _focusNode = FocusNode();
  final TextEditingController commentCon = TextEditingController();
  TextStyle contextStyle = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: TextField(
              controller: commentCon,
              focusNode: _focusNode,
              onEditingComplete: () {
                _focusNode.unfocus();
              },
              style: contextStyle,
              decoration: InputDecoration(
                hintText: '댓글을 남겨주세요.',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                blog.uploadComment(
                    widget.bdIdx, commentCon.text);
                _focusNode.unfocus();
                commentCon.text = "";
              });
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(60, 55),
                backgroundColor: Color(0xff2e2288)),
            child: Text(
              '입력',
              style: contextStyle,
            )),
      ],
    );
  }
}
