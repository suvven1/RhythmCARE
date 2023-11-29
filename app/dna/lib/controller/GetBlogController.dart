import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../url.dart';

class BlogController extends GetxController {
  static BlogController get to => Get.find();

  // 게시글 관련 변수
  RxList<Map<String, dynamic>> boardLists = RxList<Map<String, dynamic>>();
  RxList<Map<String, dynamic>> viewList= RxList<Map<String, dynamic>>();


  // 댓글 관련 변수
  RxList<Map<String, dynamic>> commentList= RxList<Map<String, dynamic>>();



  // 게시글 조회
  Future<RxList<Map<String, dynamic>>?>  getBoardData() async {
    String url = "http://${URL.ip}/board/getBoard";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'});
    var resData = jsonDecode(res.body)["boardData"];
    if (resData != false) {
      RxList<Map<String, dynamic>> boardList = RxList<Map<String, dynamic>>.from(resData.toList());
      return boardList;
    }
    return null;
  }

  // 게시글 좋아요 여부 조회
  Future<int>  getIsLiked(int bdIdx) async {
    final loginDataStorage = await SharedPreferences.getInstance();
    final id = loginDataStorage.getString('id') ?? '';

    String url = "http://${URL.ip}/board/getIsLiked";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"mem_id": id, "bd_idx": bdIdx}));
    var resData = jsonDecode(res.body)["getIsLikedResult"];
    if (resData != false) {
      return resData;
    }
    return 0;
  }

  // 댓글 조회
  Future<RxList<Map<String, dynamic>>?> getCommentData(int bdIdx) async {
    String url = "http://${URL.ip}/comment/getComment";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"bd_idx": bdIdx}));

    var resData = jsonDecode(res.body)["commentData"];

    if (resData != false) {
      RxList<Map<String, dynamic>> commentList =
      RxList<Map<String, dynamic>>.from(resData.toList());
      return commentList;
    }
    return null;
  }

@override
  void onInit() async {
    super.onInit();

  }
}