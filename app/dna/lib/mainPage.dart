import 'package:dna/blog/blogPage.dart';
import 'package:dna/calendar/calendarPage.dart';
import 'package:dna/home/homePage.dart';
import 'package:dna/hospital/hospitalPage.dart';
import 'package:dna/mypage/myPage.dart';
import 'package:flutter/material.dart';


class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {

  // 초기 페이지 2번 인덱스(홈)
  int currentPageIndex = 2;
  // 바텀 네비게이션으로 이동할 페이지 목록
  final List<Widget> pageIndex = <Widget>[
    calendarPage(),
    hospitalPage(),
    homePage(),
    blogPage(),
    myPage(),
  ];


  // 바텀 네비게이션을 클릭할 시, 실행할 메소드
  void onItemTap(index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  // // willPopScope 사용하기 위한 세팅
  //
  // // 리스트 변수 생성
  // late List<GlobalKey<NavigatorState>> _navigatorKeyList;
  // // GlobalKey를 사용해서 Navigator의 state를 받아온다.
  // @override
  // void initState(){
  //   super.initState();
  //   _navigatorKeyList = List.generate(pageIndex.length, (index) => GlobalKey<NavigatorState>());
  // }

  @override
  Widget build(BuildContext context) {
    // 네비게이터 안의 페이지에서 페이지 이동을 할 때, 기존 페이지가 지워지지 안도록
    // willPopScope로 Navigator의 state를 보고 pop될 페이지를 잡아낸다.
    // return WillPopScope(
    //   onWillPop: () async {
    //     return !(await _navigatorKeyList[currentPageIndex].currentState!.maybePop());
    //   },
    //   child : 
      return Scaffold(
        body: Navigator(
          onGenerateRoute: (routeSettings){
            return MaterialPageRoute(
                builder: (_)=> SafeArea(
                    child: pageIndex.elementAt(currentPageIndex)
                )
            );
          },
          // 기존대로 아래 코드로 할 경우,
          // 네비게이션으로 이동된 페이지 내에서 페이지 이동이 안 된다
          // 이를 Navigator로 감싸주어 이동된 페이지 내에서 이동하게 되는 것.
          // child: SafeArea(
          //   child: pageIndex.elementAt(currentPageIndex),
          // ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xff2e2288),
          unselectedItemColor: Colors.grey,
          currentIndex: currentPageIndex,
          onTap: onItemTap,

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: '달력'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital),
                label: '병원'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.heart_broken),
                label: '홈'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.backup_table_outlined),
                label: '블로그'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: '내 정보'
            ),
          ],
        ),
      // ), willpop 사용 시, 괄호
    );
  }
}