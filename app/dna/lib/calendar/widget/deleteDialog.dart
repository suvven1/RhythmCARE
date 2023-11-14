import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class deleteDialog extends StatelessWidget {
  const deleteDialog({
    Key? key,
    this.todayList,
    this.toDoList,
  }) : super(key: key);

  final List<String>? todayList;
  final toDoList;

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
                  color: Color(int.parse(todayList![3]))),
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
                          todayList![0],
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
                            todayList![1],
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
                            todayList![2],
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
                    toDoList.remove(todayList);
                    Get.back();
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
                    Get.back();
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
