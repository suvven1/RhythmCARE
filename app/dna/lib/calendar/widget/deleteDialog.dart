import 'dart:convert';

import 'package:dna/snackBarMessage/snackBar.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class deleteDialog extends StatelessWidget {
  const deleteDialog({
    Key? key,
    this.todayList,
    this.toDoList,
    this.context
  }) : super(key: key);

  final List<String>? todayList;
  final toDoList;
  final context;
  void deleteSchedule() async {
    print(todayList);

    String url = "http://192.168.1.106:3333/calender/deleteSchedule";
    http.Response res = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"id": todayList?[1], "key": todayList?[0]}));
    // 일정 삭제 결과를 받아와 변수에 저장
    var resData = jsonDecode(res.body)["deleteScheduleResult"];


      if (resData) {
        showSnackBar(context,"일정이 삭제되었습니다.", 2);
        Get.back(result: true);
      }else{
        showSnackBar(context,"일정을 삭제하지 못 했습니다.", 2);
      }


  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '일정 상세 정보',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizeBoxH30,
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(int.parse(todayList![5]))),
            ),
            SizeBoxH10,
            Row(
              children: [
                Text(
                  '내용',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          todayList![2],
                          style: TextStyle(fontSize: 25),
                        ),
                      )),
                ),
              ],
            ),
            SizeBoxH10,
            Row(
              children: [
                Text(
                  '시작',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            todayList![3],
                            style: TextStyle(fontSize: 25),
                          ),
                        ))),
              ],
            ),
            SizeBoxH10,
            Row(
              children: [
                Text(
                  '종료',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            todayList![4],
                            style: TextStyle(fontSize: 25),
                          ),
                        ))),
              ],
            ),
            SizeBoxH30,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    deleteSchedule();
                  },
                  child: SizedBox(
                    height: 45,
                    child: Center(
                      child: Text(
                        '일정 삭제하기',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff2e2288)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back(result: false);
                  },
                  child: SizedBox(
                    height: 45,
                    child: Center(
                      child: Text(
                        '닫기',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[300]),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
