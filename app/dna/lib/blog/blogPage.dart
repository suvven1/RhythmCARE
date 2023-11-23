import 'dart:typed_data';

import 'package:dna/blog/communityWrite.dart';
import 'package:dna/blog/widget/communityTitle.dart';
import 'package:dna/blog/widget/postContainer.dart';
import 'package:dna/blog/widget/postListNum.dart';
import 'package:dna/blog/widget/search.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class blogPage extends StatefulWidget {
  const blogPage({super.key});

  @override
  State<blogPage> createState() => _blogPageState();
}

class _blogPageState extends State<blogPage> {
  // test용 더미데이터
  List<List<dynamic>> dataDB = List.generate(
      50,
          (index) =>
      [
        index,
        52,
        false,
        3,
        [],
        '하병권',
        DateTime.now().subtract(Duration(days: index)),
        '게시물 제목$index',
        '게시물 내용$index'*10,
        //   /*
        //   0 : 글 번호
        //   1 : 공감 수
        //   2 : 공감 여부
        //   3 : 댓글 수
        //   4 : 글쓴이 대표이미지
        //   5 : 글쓴이 닉네임
        //   6 : 글 작성일자
        //   7 : 게시물 제목
        //   8 : 게시물 내용
        //   */
        //   위 인덱스 번호에 맞는 데이터를 아래 예시처럼 리스트로 넣어주면 됨.
        //   인덱스 번호 바꾸려면 밑에 게시물 양식에서 변수 초기화 부분이랑 같이 바꾸면 됨.
        //   [0, 52, 3, [], '하병권', '2023-11-22', '게시물 제목1', '게시물 내용1'],
        //   [1, 52, 3, [], '하병권', '2023-11-23', '게시물 제목2', '게시물 내용2'],
      ]);


  /*
  작동순서
  1. DB를 불러온다.
  2. 현재 보고 있는 페이지 번호에 맞는 게시물 정보를 viewList에 담는다.
  3. viewList를 바탕으로 [글 목록 ListView(postContainer)]를 작성한다.
  */

  // 현재 창에 보일 데이터 리스트
  late List<List<dynamic>> viewList;
  // 현재 창에 보일 데이터 리스트 초기화 함수
  void viewListFt (){
    viewList = List.generate(viewListNum == viewListCount
        ? dataDB.length - viewListCount * 7
        : 7, (index) => dataDB[index + viewListNum * 7]);
    print(viewList);
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
    _refreshIndicator.currentState?.show();
    print(viewListNum);
  }

  late int viewListCount;

  @override
  void initState() {
    super.initState();
    viewListCount = (dataDB.length - 1) ~/ 7;
    viewListFt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicator,
        onRefresh: () async {
          setState(() {
            viewListFt();
            showToast("화면새로고침 완료");
          });
        },
        child: Container(
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
                    ListView.builder(
                      itemCount: viewList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return postContainer(
                            dataDB: viewList[index]);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12, right: 4),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(communityWrite());
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 5, bottom: 5),
                              backgroundColor: Color(0xff2e2288),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12)))
                          ),
                          child: Text('글쓰기',
                              style: TextStyle(
                                fontSize: 25,))),
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
      ),
    );
  }

  // 검색창
  TextEditingController searchCon = TextEditingController();

  void searchButtonAction() {
    print(searchCon.text);
  }
}
