import 'dart:convert';
import 'dart:typed_data';

import 'package:dna/blog/communityWrite.dart';
import 'package:dna/blog/widget/communityTitle.dart';
import 'package:dna/blog/widget/postContainer.dart';
import 'package:dna/blog/widget/postListNum.dart';
import 'package:dna/blog/widget/search.dart';
import 'package:dna/controller/GetBlogController.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../url.dart';
class blogPage extends StatefulWidget {
  const blogPage({super.key});

  @override
  State<blogPage> createState() => _blogPageState();
}

class _blogPageState extends State<blogPage> {
  BlogController blog = Get.put(BlogController());

  // 현재 창에 보일 데이터 리스트
  List<Map<String,dynamic>>? searchList;

  // 하단 숫자버튼 클릭 시,
  // 현재 보고 있는 페이지 변수 변환 후 새로고침
  final GlobalKey<RefreshIndicatorState> _refreshIndicator =
  GlobalKey<RefreshIndicatorState>();

  void viewFt(int selectedNum) {
    // 하단 게시물 번호 클릭했을 때 실행되는 함수
    // 게시물 클릭 시, db를 불러와야 할 때 여기로 불러오면 됨.
    blog.viewListNum.value = selectedNum;
    blog.viewListFt(searchList ?? blog.boardLists);
    _refreshIndicator.currentState?.show();
  }

  bool isDraging = false;
  void viewRightFt() {
    // 하단 게시물 번호 클릭했을 때 실행되는 함수
    // 게시물 클릭 시, db를 불러와야 할 때 여기로 불러오면 됨.
    blog.viewListNum.value++;
    isDraging = true;
    blog.viewListFt(searchList ?? blog.boardLists);
    _refreshIndicator.currentState?.show();
  }
  void viewLeftFt() {
    // 왼쪽으로  때 실행되는 함수
    // 게시물 클릭 시, db를 불러와야 할 때 여기로 불러오면 됨.
    blog.viewListNum.value--;
    isDraging = true;
    blog.viewListFt(searchList ?? blog.boardLists);
    _refreshIndicator.currentState?.show();
  }

  @override
  void initState() {
    super.initState();
    blog.fetchData();
  }

  FocusNode textFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicator,
      onRefresh: () async {
        if(isSearched){
          if(!searchCon.text.isNotEmpty){
            setState(() {
              blog.fetchData();
            });
          }
          isSearched = false;
        }else{
          setState(() {
            blog.fetchData();
            searchCon.text = "";
          });
        }
      },
      child: GestureDetector(
        onTap: (){
          textFocus.unfocus();
        },
        child: Obx(()=>
          Container(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            color: Colors.white,
            child: Column(
              children: [
                SizeBoxH40,
                search(
                    searchCon: searchCon, searchButtonAction: searchButtonAction, focusNode: textFocus),
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      GestureDetector(
                        onHorizontalDragUpdate: (details) async{
                          textFocus.unfocus();
                          if(details.delta.dx < -7 && !isDraging && blog.viewListNum.value < blog.viewListCount.value){
                            viewRightFt();
                            print('right');
                            Future.delayed(Duration(milliseconds: 500), (){
                              isDraging = false;
                            });
                          } else if(details.delta.dx > 7 && !isDraging && blog.viewListNum.value >0){
                            viewLeftFt();
                            print('left');
                            Future.delayed(Duration(milliseconds: 500), (){
                              isDraging = false;
                            });
                          }
                        },
                        child: ListView.builder(
                          itemCount: blog.viewList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return postContainer(
                                  key: ValueKey(blog.viewList[index]["bd_idx"]),
                                  dataDB: blog.viewList[index]);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, right: 4),
                        child: ElevatedButton(
                            onPressed: () {
                              // Get.to(communityWrite());
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return communityWrite();
                                },
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  right: 20,
                                  left: 20,
                                ),
                                backgroundColor: Color(0xff2e2288),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                            child: Text('글쓰기',
                                style: TextStyle(
                                  fontSize: 25,
                                ))),
                      )
                    ],
                  ),
                ),
                horisonLine,
                postListNum(
                    viewListNum: blog.viewListNum.value,
                    viewFt: viewFt,
                    viewListCount: blog.viewListCount.value),
                horisonLine,
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 검색창
  TextEditingController searchCon = TextEditingController();
  bool isSearched = false;
  void searchButtonAction() {
      isSearched = true;
      textFocus.unfocus();
      searchList =
          blog.boardLists.where((element) => element["bd_title"].contains(searchCon.text)).toList();
      blog.viewListCount.value = (searchList!.length - 1) ~/ 7;
      setState(() {
        blog.viewListNum.value = 0;
      });
      blog.viewListFt(searchList!);
      _refreshIndicator.currentState?.show();
    }
}