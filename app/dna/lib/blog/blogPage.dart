import 'dart:typed_data';

import 'package:dna/blog/widget/communityTitle.dart';
import 'package:dna/blog/widget/postListNum.dart';
import 'package:dna/blog/widget/search.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';

class blogPage extends StatefulWidget {
  const blogPage({super.key});

  @override
  State<blogPage> createState() => _blogPageState();
}

class _blogPageState extends State<blogPage> {
  // test용 더미데이터
  List<List<dynamic>> dataDB = List.generate(
      50,
      (index) => [
            index,
            52,
            3,
            [],
            '하병권',
            DateTime.now()
                .subtract(Duration(days: index))
                .toString()
                .split(' ')[0],
            '게시물 제목$index'
          ]);

  // [
  //   /*
  //   0 : 글 번호
  //   1 : 공감 수
  //   2 : 댓글 수
  //   3 : 글쓴이 대표이미지
  //   4 : 글쓴이 닉네임
  //   5 : 글 작성일자
  //   6 : 게시물 제목
  //   */
  //   위 인덱스 번호에 맞는 데이터를 아래 예시처럼 리스트로 넣어주면 됨.
  //   인덱스 번호 바꾸려면 밑에 게시물 양식에서 변수 초기화 부분이랑 같이 바꾸면 됨.
  //   [0, 52, 3, [], '하병권', '2023-11-22', '게시물 제목1'],
  //   [1, 52, 3, [], '하병권', '2023-11-23', '게시물 제목2'],
  // ];

  // 하단 숫자버튼 클릭 시,
  // 현재 보고 있는 페이지 변수 변환 후 새로고침
  final GlobalKey<RefreshIndicatorState> _refreshIndicator =
      GlobalKey<RefreshIndicatorState>();
  int viewListNum = 0;

  void viewFt(int selectedNum) {
    viewListNum = selectedNum;
    _refreshIndicator.currentState?.show();
    print(viewListNum);
  }

  late int viewListCount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewListCount = (dataDB.length - 1) ~/ 7;
    print(viewListCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicator,
        onRefresh: () async {
          setState(() {
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
                child: ListView(
                  children: List.generate(
                      viewListNum == viewListCount
                          ? dataDB.length - viewListCount * 7
                          : 7,
                      (index) =>
                          postContainer(dataDB[index + viewListNum * 7])),
                ),
              ),
              horisonLine,
              postListNum(
                  viewListNum: viewListNum,
                  viewFt: viewFt,
                  viewListCount: viewListCount),
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

  // 게시물 양식
  Widget postContainer(List<dynamic> dataDB) {
    int postNum = dataDB[0];
    int likeNum = dataDB[1];
    int commentNum = dataDB[2];
    List<int> writerImage = List<int>.from(dataDB[3]);
    String writerNick = dataDB[4];
    String date = dataDB[5];
    String title = dataDB[6];
    const TextStyle textStyle = TextStyle(fontSize: 20);
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide())),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizeBoxH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'no. $postNum',
                style: textStyle,
              ),
              Row(
                children: [
                  Image.asset(
                    'image/heart_good.png',
                    height: 25,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      '$likeNum',
                      style: textStyle,
                    ),
                  ),
                  Image.asset(
                    'image/navigationBarIcon/icon_db.png',
                    height: 25,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 40,
                    child: Text('$commentNum', style: textStyle),
                  ),
                ],
              ),
            ],
          ),
          SizeBoxH20,
          Row(
            children: [
              ClipOval(
                child: writerImage.isNotEmpty
                    ? Image.memory(
                        Uint8List.fromList(writerImage),
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
                    writerNick,
                    style: textStyle,
                  ),
                  Text(
                    date,
                    style: textStyle,
                  ),
                ],
              )
            ],
          ),
          SizeBoxH20,
          Text(
            title,
            style: textStyle,
          ),
          SizeBoxH30
        ],
      ),
    );
  }
}
