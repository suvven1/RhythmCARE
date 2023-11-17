import 'package:flutter/material.dart';
import 'package:dna/member/widget/textField.dart';
import 'package:flutter_blue/flutter_blue.dart';

void checkBlue  (context) async {
// 블루투스 활성화 여부 확인
  bool isBluetoothEnabled =
  await FlutterBlue.instance.isOn;
  if (!isBluetoothEnabled) {
// 블루투스가 비활성화된 경우 활성화 요청
    await ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      content: Text('블루투스 연결필요'),
      duration: const Duration(seconds: 2),
    ));
  }
}





// 탈퇴 인증 모달장
showConnectDialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 380,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Image.asset(
                  'image/Logo2.png',
                  width: MediaQuery.of(context).size.width * 0.65,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2e2288),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: 50,
                        child: Center(
                          child: Text(
                            '기기연결',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onPressed: () {
                        checkBlue(context);
                      },
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2e2288),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: 50,
                        child: Center(
                          child: Text(
                            '다음에 연결',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
