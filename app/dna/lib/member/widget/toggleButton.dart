import 'package:flutter/material.dart';

toggleButton (BuildContext context, isSelected, toggleSelect){
  return ToggleButtons(
    constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width*0.39),
    borderColor: Color(0xff2e2288), // 큰 박스 선 색
    selectedBorderColor: Color(0xff2e2288), // 선택된 박스 선 색
    borderRadius: BorderRadius.all(Radius.circular(50)), // 큰 박스 선 둥글게
    highlightColor: Colors.transparent, // 클릭 시, 동그랗게 퍼지는 색
    fillColor: Color(0xff2e2288), // 선택된 박스 색
    selectedColor: Colors.white, // 선택된 박스 텍스트 색
    color: Colors.grey, // 미 선택된 박스 텍스트 색
    textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    isSelected: isSelected,
    onPressed: toggleSelect,
    children: [
      Container(
        child: const Center(child: Text('보호자 로그인')),
      ),
      Container(
        child: const Center(child: Text('사용자 로그인')),
      ),
    ],
  );
}