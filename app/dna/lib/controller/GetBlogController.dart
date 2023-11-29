import 'dart:convert';

import 'package:dna/toastMessage/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../url.dart';

class BlogController extends GetxController {
  static BlogController get to => Get.find();

  late String id;

  // 게시글 관련 변수
  RxList<Map<String, dynamic>> boardLists = RxList<Map<String, dynamic>>();
  RxList<Map<String, dynamic>> viewList= RxList<Map<String, dynamic>>();

  // 게시글 조회 / 작성 / 삭제------------------------------------------------------------------------
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

  // -----------------------------------------------------------------------------------------------------
  // 게시글 작성
  void uploadBoard(String title, String content, context) async {
    String url = "http://${URL.ip}/board/uploadBoard";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"title": title, "content":content, "id": id }));
    var resData = jsonDecode(res.body)["uploadBoardResult"];
    if (resData) {
      showToast("게시글 작성이 완료 되었습니다.");
      Navigator.pop(context);
    }else{
      showToast("[네트워크 에러] 게시글 추가 실패");
    }
  }

  // 게시글 삭제
  void deleteBoard(int bdIdx, context) async {
    String url = "http://${URL.ip}/board/deleteBoard";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"id": id, "bd_idx": bdIdx}));
    var resData = jsonDecode(res.body)["deleteBoardResult"];
    if (resData) {
      showToast("게시글 삭제가 완료 되었습니다.");
      Navigator.pop(context);
    }else{
      showToast("[네트워크 에러] 게시글 삭제 실패");
    }
  }


  // 게시글 좋아요 조회 / 추가 / 삭제------------------------------------------------------------------------
  // 게시글 좋아요 조회
  Future<int>  getIsLiked(int bdIdx) async {
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

  // 게시글 좋아요 추가
  void likesAdd(int bdIdx) async {
    String url = "http://${URL.ip}/board/likesAdd";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"mem_id": id, "bd_idx": bdIdx}));
    var resData = jsonDecode(res.body)["likesAddResult"];
    if (!resData) {
    showToast("[네트워크 에러] 좋아요 추가 실패");
    }
  }

  // 게시글 좋아요 삭제
  void likesPop(int bdIdx) async {
    String url = "http://${URL.ip}/board/likesPop";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"mem_id": id, "bd_idx": bdIdx}));
    var resData = jsonDecode(res.body)["likesPopResult"];
    if (!resData) {
      showToast("[네트워크 에러] 좋아요 제거 실패");
    }
  }

  // -----------------------------------------------------------------------------------------------------
  // 댓글 관련 변수
  RxList<Map<String, dynamic>> commentList= RxList<Map<String, dynamic>>();
  RxList<bool> commentLikeBoolList = RxList<bool>();

  // 댓글 조회 / 추가---------------------------------------------------------------------------------------
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

  // 댓글 추가
  void uploadComment(int bdIdx, String content) async {
    String url = "http://${URL.ip}/comment/uploadComment";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"bd_idx": bdIdx, "cmt_content":content, "mem_id": id }));
    var resData = jsonDecode(res.body)["uploadCommentResult"];
    if (!resData) {
      showToast("[네트워크 에러] 댓글 추가 실패");
    }
  }

  // 댓글 좋아요 조회 / 추가 / 삭제------------------------------------------------------------------------
  // 댓글 좋아요 조회
  Future<bool> getIsCmtLiked(int cmtIdx) async {
    String url = "http://${URL.ip}/comment/getIsCmtLiked";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"mem_id": id, "cmt_idx": cmtIdx}));
    var resData = jsonDecode(res.body)["getIsLikedResult"];
    if (resData != false) {
      return true;
    }
    return false;
  }

  // 댓글 좋아요 추가
  void cmtLikesAdd(int cmtIdx) async {
    String url = "http://${URL.ip}/comment/cmtLikesAdd";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"mem_id": id, "cmt_idx": cmtIdx}));
    var resData = jsonDecode(res.body)["result"];
    if (!resData) {
      showToast("[네트워크 에러] 좋아요 추가 실패");
    }
  }

  // 댓글 좋아요 삭제
  void cmtLikesPop(int cmtIdx) async {
    String url = "http://${URL.ip}/comment/cmtLikesPop";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"mem_id": id, "cmt_idx": cmtIdx}));
    var resData = jsonDecode(res.body)["result"];
    if (!resData) {
      showToast("[네트워크 에러] 좋아요 제거 실패");
    }
  }

@override
  void onInit() async {
    super.onInit();
    final loginDataStorage = await SharedPreferences.getInstance();
    id = loginDataStorage.getString('id') ?? '';
  }
}