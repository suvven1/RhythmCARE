import 'package:flutter/material.dart';

toggleButton2(BuildContext context, isSelected, toggleSelect) {
  return ToggleButtons(
    borderColor: Colors.transparent,
    // 큰 박스 선 색
    renderBorder: false,
    // 선택된 박스 선 색
    highlightColor: Colors.transparent,
    // 클릭 시, 동그랗게 퍼지는 색
    fillColor: Colors.transparent,
    // 선택된 박스 색
    selectedColor: Color(0xff2e2288),
    // 선택된 박스 텍스트 색
    color: Colors.grey,
    // 미 선택된 박스 텍스트 색
    textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    isSelected: isSelected,
    onPressed: toggleSelect,
    children: [
      SizedBox(
          width: 100,
          child: const Center(
              child: Text(
                '아이디 찾기',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ))),
      SizedBox(
          width: 100,
          child: const Center(
              child: Text(
                '비밀번호 찾기',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ))),
    ],
  );
}
