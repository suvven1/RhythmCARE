import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../url.dart';

class BlogController extends GetxController {
  static BlogController get to => Get.find();

  // 게시글 관련
  RxList<Map<String, dynamic>> boardLists = RxList<Map<String, dynamic>>();
  RxList<Map<String, dynamic>> viewList= RxList<Map<String, dynamic>>();


  // 댓글 관련
  RxList<Map<String, dynamic>> commentList= RxList<Map<String, dynamic>>();

  // final loginDataStorage = await SharedPreferences.getInstance();
  // final id = loginDataStorage.getString('id') ?? '';



@override
  void onInit() async {
    super.onInit();

  }
}