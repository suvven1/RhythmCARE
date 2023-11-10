import 'package:flutter/material.dart';

myBottomNavi (currentPageIndex, onItemTap){
  return BottomNavigationBar(
    selectedItemColor: Color(0xff2e2288),
    unselectedItemColor: Colors.grey,
    currentIndex: currentPageIndex,
    onTap: onItemTap,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month), label: '달력'),
      BottomNavigationBarItem(
          icon: Icon(Icons.local_hospital), label: '병원'),
      BottomNavigationBarItem(icon: Icon(Icons.heart_broken), label: '홈'),
      BottomNavigationBarItem(
          icon: Icon(Icons.backup_table_outlined), label: '블로그'),
      BottomNavigationBarItem(
          icon: Icon(Icons.account_circle), label: '내 정보'),
    ],
  );
  // return BottomNavigationBar(
  //   type: BottomNavigationBarType.fixed,
  //   showUnselectedLabels: false,
  //   currentIndex: currentPageIndex,
  //   onTap: onItemTap,
  //   items: <BottomNavigationBarItem>[
  //     BottomNavigationBarItem(
  //       // 선택된 탭 인덱스(selectedIndex) 값에 따라
  //       // 0이면 색칠된 아이콘, 아니라면 회색 아이콘 (3항 연산자)
  //         icon: currentPageIndex ==
  //             0 // 선택된 탭은 채워진 아이콘, 나머지는 line 아이콘
  //             ? Image.asset(
  //           'image/navigationBarIcon/icon_aa.png',
  //         )
  //             : Image.asset(
  //           // 'image/navigationBarIcon/icon_ab.png',
  //             'image/logo.png'
  //         ),
  //         label: "달력"),
  //     BottomNavigationBarItem(
  //         icon: currentPageIndex == 1
  //             ? Image.asset(
  //           'image/navigationBarIcon/icon_ba.png',
  //         )
  //             : Image.asset(
  //           'image/navigationBarIcon/icon_bb.png',
  //         ),
  //         label: "병원"),
  //     BottomNavigationBarItem(
  //         icon: currentPageIndex == 2
  //             ? Image.asset(
  //           'image/navigationBarIcon/icon_ca.png',
  //         )
  //             : Image.asset(
  //           'image/navigationBarIcon/icon_cb.png',
  //         ),
  //         label: "홈"),
  //     BottomNavigationBarItem(
  //         icon: currentPageIndex == 3
  //             ? Image.asset(
  //           'image/navigationBarIcon/icon_da.png',
  //         )
  //             : Image.asset(
  //           'image/navigationBarIcon/icon_db.png',
  //         ),
  //         label: "블로그"),
  //     BottomNavigationBarItem(
  //         icon: currentPageIndex == 4
  //             ? Image.asset(
  //           'image/navigationBarIcon/icon_ea.png',
  //         )
  //             : Image.asset(
  //           'image/navigationBarIcon/icon_eb.png',
  //         ),
  //         label: "내 정보"),
  //   ],
  // );
}