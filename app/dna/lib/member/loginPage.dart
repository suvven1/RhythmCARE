import 'package:dna/member/widget/textField.dart';
import 'package:dna/member/widget/toggleButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../mainPage.dart';
import '../widget/sizeBox.dart';
import 'findPage.dart';
import 'joinPage.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController idCon = TextEditingController();
  TextEditingController pwCon = TextEditingController();

  // toggle 변수
  bool isGuard = true;
  bool isUser = false;
  late List<bool> isSelected;

  // isSelected 초기화
  @override
  void initState() {
    isSelected = [isGuard, isUser];
    super.initState();
    initialization();
  }
  void initialization() async {
    await Future.delayed(Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  void printIdPw(bool who, idCon, pwCon){
    print(who);
    print(idCon.text);
    print(pwCon.text);
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
                children: [
                  Image.asset('image/logo.png'),
                  SizeBoxH50,
                  toggleButton(context, isSelected, toggleSelect),
                  SizeBoxH30,
                  textField(idCon, "아이디"),
                  SizeBoxH10,
                  textField(pwCon, "비밀번호"),
                  SizeBoxH40,
                  // FlaltButton 은 화면 위에 떠있는 동그란 버튼
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2e2288)),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Center(child: Text('로그인')),
                    ),
                    onPressed: () {
                      // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      /*
                      * Unhandled Exception: This widget has been unmounted,
                      * so the State no longer has a context (and should be considered defunct).
                      * navigator로 이어진 페이지들을 삭제할 시, context가 사라져서
                      * 더 이상 context를 마운트 할 수 없게 되어 해당 오류가 생김.
                      * 이거 어케 해결함??
                      * 저걸 넣은 이유는 메인 페이지에서 뒤로가기 눌렀을 때 로그인 창이랑 스플래시 떠서..
                      * */

                      // 로그인 버튼 클릭 시, id pw 를 run 창에 출력
                      // true : 보호자, false : 사용자
                      printIdPw(isGuard, idCon, pwCon);
                      // 로그인 버튼 클릭 시, 액션을 여기에 넣으면 됨
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => mainPage()));
                    },
                  ),
                  SizeBoxH20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>findPage()));
                          },
                          child: Text('아이디 찾기',
                              style: TextStyle(color: Colors.black))),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>findPage()));
                          },
                          child: Text('비밀번호 찾기',
                              style: TextStyle(color: Colors.black))),
                    ],
                  )
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
    } else {
      isGuard = false;
      isUser = true;
    }
    setState(() {
      isSelected = [isGuard, isUser];
    });
  }
}
