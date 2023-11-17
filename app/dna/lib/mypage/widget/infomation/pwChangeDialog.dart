import 'package:dna/member/widget/textFieldCheck.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class pwChangeDialog extends StatefulWidget {
  const pwChangeDialog({super.key});

  @override
  State<pwChangeDialog> createState() => _pwChangeDialogState();
}

class _pwChangeDialogState extends State<pwChangeDialog> {
  final TextStyle style = TextStyle(fontSize: 17);
  final TextEditingController pwCon = TextEditingController();
  final TextEditingController newPwCon = TextEditingController();
  final TextEditingController newPwCon2 = TextEditingController();
  int pwCheck = 0;
  int useablePw = 0;
  int useablePw2 = 0;

  // 비밀번호 변경 test
  // 해당 변수와 입력한 비밀번호가 같으면 파래짐
  String test = '1234';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pwCon.addListener(() {
      checkStatePw(test, pwCon);
    });
    newPwCon.addListener(() {
      checkStatePw2(test, newPwCon);
    });
    newPwCon2.addListener(() {
      checkStatePw3(newPwCon.text, newPwCon2);
    });
  }

  void checkStatePw (String check, TextEditingController textCon){
    setState(() {
      pwCheck = textCon.text=='' ? 0 : textCon.text == check ? 1 : 2;
    });
  }
  void checkStatePw2 (String check, TextEditingController textCon){
    setState(() {
      useablePw = textCon.text=='' ? 0 : textCon.text == check ? 1 : 2;
    });
  }
  void checkStatePw3 (String check, TextEditingController textCon){
    setState(() {
      useablePw2 = textCon.text=='' ? 0 : textCon.text == check ? 1 : 2;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        backgroundColor: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('image/logo_low.png'),
              Text(
                '기존 비밀번호 입력 후',
                style: style,
              ),
              Text(
                '변경할 비밀번호를 입력해주세요.',
                style: style,
              ),
              SizeBoxH10,
              textFieldCheck(Con: pwCon, hint: '기존 비밀번호', checkIcon: pwCheck),
              SizeBoxH10,
              textFieldCheck(Con: newPwCon, hint: '변경할 비밀번호', checkIcon: useablePw),
              SizeBoxH10,
              textFieldCheck(Con: newPwCon2, hint: '비밀번호 확인', checkIcon: useablePw2),
              SizeBoxH30,
              ElevatedButton(onPressed: (){
                Get.back();
              }, child: Text('변경'), style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff2e2288),
                minimumSize: Size(double.infinity, 50),
                textStyle: TextStyle(fontSize: 20,),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)))
              ),),
              SizedBox(height: 5,),
              ElevatedButton(onPressed: (){
                Get.back();
              }, child: Text('취소'), style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  minimumSize: Size(double.infinity, 40),
                  textStyle: TextStyle(fontSize: 20,),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)))
              ),),
            ],
          ),
        ));
  }
}
