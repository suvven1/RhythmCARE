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

  // 현재 게시글의 양에 대한 페이지 수
  late int viewListCount = 1;

  // 현재 창에 보일 데이터 리스트
  List<Map<String,dynamic>>? searchList;

  // 현재 창에 보일 데이터 리스트 초기화 함수
  void viewListFt(List list) {
    blog.viewList = RxList.generate(
        viewListNum == viewListCount ? list.length - viewListCount * 7 : 7,
            (index) => list[index + viewListNum * 7]);
  }

  // 하단 숫자버튼 클릭 시,
  // 현재 보고 있는 페이지 변수 변환 후 새로고침
  final GlobalKey<RefreshIndicatorState> _refreshIndicator =
  GlobalKey<RefreshIndicatorState>();
  int viewListNum = 0;

  void viewFt(int selectedNum) {
    // 하단 게시물 번호 클릭했을 때 실행되는 함수
    // 게시물 클릭 시, db를 불러와야 할 때 여기로 불러오면 됨.
    viewListNum = selectedNum;
    viewListFt(searchList ?? blog.boardLists);
    _refreshIndicator.currentState?.show();
  }

  bool isDraging = false;
  void viewRightFt() {
    // 하단 게시물 번호 클릭했을 때 실행되는 함수
    // 게시물 클릭 시, db를 불러와야 할 때 여기로 불러오면 됨.
    viewListNum++;
    isDraging = true;
    viewListFt(searchList ?? blog.boardLists);
    _refreshIndicator.currentState?.show();
  }
  void viewLeftFt() {
    // 왼쪽으로  때 실행되는 함수
    // 게시물 클릭 시, db를 불러와야 할 때 여기로 불러오면 됨.
    viewListNum--;
    isDraging = true;
    viewListFt(searchList ?? blog.boardLists);
    _refreshIndicator.currentState?.show();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    // 데이터를 받아오는 비동기 함수 (예: API 호출 등)
      blog.boardLists = (await blog.getBoardData())!;

    // 데이터가 정상적으로 받아와졌다면 실행
    if (blog.boardLists.isNotEmpty) {
      setState(() {
        viewListCount = (blog.boardLists.length - 1) ~/ 7;
        viewListFt(blog.boardLists);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicator,
      onRefresh: () async {
        setState(() {
          fetchData();
        });
      },
      child: Container(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05),
        color: Colors.white,
        child: Column(
          children: [
            SizeBoxH40,
            search(
                searchCon: searchCon, searchButtonAction: searchButtonAction),
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  GestureDetector(
                    onHorizontalDragUpdate: (details) async{
                      if(details.delta.dx < -7 && !isDraging && viewListNum < viewListCount){
                        viewRightFt();
                        print('right');
                        Future.delayed(Duration(milliseconds: 500), (){
                          isDraging = false;
                        });
                      } else if(details.delta.dx > 7 && !isDraging && viewListNum >0){
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
                        return Obx(() =>
                          postContainer(
                            // key를 부여하지 않는다면,
                            // flutter는 기본적으로 같은 키에 대해
                            // 재사용을 하기 때문에 상태변화가 일어나지 않을 수 있다.
                              key: ValueKey(blog.viewList[index]["bd_idx"]),
                              dataDB: blog.viewList[index]),
                        );
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
                viewListNum: viewListNum,
                viewFt: viewFt,
                viewListCount: viewListCount),
            horisonLine,
          ],
        ),
      ),
    );
  }

  // 검색창
  TextEditingController searchCon = TextEditingController();

  void searchButtonAction() {
    searchList =
        blog.boardLists.where((element) => element["bd_title"].contains(searchCon.text)).toList();
    viewListCount = (searchList!.length - 1) ~/ 7;
    setState(() {
      viewListNum = 0;
    });
    viewListFt(searchList!);
    _refreshIndicator.currentState?.show();
  }
}