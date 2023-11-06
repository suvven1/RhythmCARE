import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'findSettingPage.dart';
import 'joinPage.dart';

class findPage extends StatefulWidget {
  const findPage({super.key});

  @override
  State<findPage> createState() => _findPageState();
}

class _findPageState extends State<findPage> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController birthCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();

  String findIt = '아이디';

  // toggle 변수
  bool isGuard = true;
  bool isUser = false;
  late List<bool> isSelected;

  // isSelected 초기화
  @override
  void initState() {
    isSelected = [isGuard, isUser];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Transform.scale(
          scale: 0.82, // 로그인 화면 여백 지정
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('image/logo.png'),
                  SizeBoxH50,
                  ToggleButtons(
                    borderColor: Colors.transparent, // 큰 박스 선 색
                    renderBorder: false, // 선택된 박스 선 색
                    highlightColor: Colors.transparent, // 클릭 시, 동그랗게 퍼지는 색
                    fillColor: Colors.transparent, // 선택된 박스 색
                    selectedColor: Color(0xff2e2288), // 선택된 박스 텍스트 색
                    color: Colors.grey, // 미 선택된 박스 텍스트 색
                    isSelected: isSelected,
                    onPressed: toggleSelect,
                    children: [
                      SizedBox(width: 100, child: const Center(child: Text('아이디 찾기',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),))),
                      SizedBox(width: 100, child: const Center(child: Text('비밀번호 찾기',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),))),
                    ],
                  ),
                  SizeBoxH30,
                  TextField(
                    controller: nameCon,
                    decoration: const InputDecoration(
                      labelText: '보호자 성명',
                    ),
                  ),
                  SizeBoxH10,
                  TextField(
                    controller: birthCon,
                    decoration: const InputDecoration(
                      labelText: '보호자 생년월일 8자리',
                    ),
                  ),
                  SizeBoxH10,
                  TextField(
                    controller: phoneCon,
                    decoration: const InputDecoration(
                      labelText: '보호자 휴대폰번호',
                    ),
                  ),
                  SizeBoxH40,
                  // FlaltButton 은 화면 위에 떠있는 동그란 버튼
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2e2288)),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Center(child: Text('$findIt 찾기')),
                    ),
                    onPressed: () {
                      if(findIt == '아이디') {
                        Navigator.pop(context);
                      } else{
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>findSettingPage()));
                      }
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아직 계정이 없으신가요?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => joinPage()));
                    },
                    child: Text('회원가입',
                        style: TextStyle(
                            color: Color(0xff2e2288),
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // toggle 함수
  void toggleSelect(value) {
    if (value == 0) {
      isGuard = true;
      isUser = false;
      findIt = '아이디';
    } else {
      isGuard = false;
      isUser = true;
      findIt = '비밀번호';
    }
    setState(() {
      isSelected = [isGuard, isUser];
    });
  }
}
