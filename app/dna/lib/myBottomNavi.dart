import 'package:flutter/material.dart';

myBottomNavi(currentPageIndex, onItemTap) {
  Image iconImage (int itemNum, bool onTrue){
    String item = 'a';
    String onoff = onTrue ? 'a' : 'b';
    switch (itemNum){
      case 1:
        item = 'a';
        break;
      case 2:
        item = 'b';
        break;
      case 3:
        item = 'c';
        break;
      case 4:
        item = 'd';
        break;
      case 5:
        item = 'e';
        break;
    }
    return Image.asset('image/navigationBarIcon/icon_'+item+onoff+'.png', width: 30,);
  }
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: false,
    currentIndex: currentPageIndex,
    onTap: onItemTap,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: iconImage(1, false),
        activeIcon: iconImage(1, true),
        label: "달력",
      ),
      BottomNavigationBarItem(
          icon: iconImage(2, false),
          activeIcon: iconImage(2, true),
          label: "병원"),
      BottomNavigationBarItem(
          icon: iconImage(3, false),
          activeIcon: iconImage(3, true),
          label: "홈"),
      BottomNavigationBarItem(
          icon: iconImage(4, false),
          activeIcon: iconImage(4, true),
          label: "커뮤니티"),
      BottomNavigationBarItem(
          icon: iconImage(5, false),
          activeIcon: iconImage(5, true),
          label: "내 정보"),
    ],
  );
}
