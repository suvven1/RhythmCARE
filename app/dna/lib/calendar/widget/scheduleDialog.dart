import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class scheduleDialog extends StatefulWidget {
  const scheduleDialog({
    super.key,
    required this.selectedYear,
    required this.selectedMonth,
    required this.selectedDay,
    required this.toDoList,
    required this.todoColor,
  });

  final selectedYear;
  final selectedMonth;
  final selectedDay;
  final toDoList;
  final todoColor;

  @override
  State<scheduleDialog> createState() => _scheduleDialogState();
}

class _scheduleDialogState extends State<scheduleDialog> {
  TextEditingController schaduleCon = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime startDayAdd = DateTime.now();
  DateTime lastDayAdd = DateTime.now();
  DateTime? startDay;
  DateTime? lastDay;

  @override
  void initState() {
    super.initState();
    selectedDate =
        DateTime(widget.selectedYear, widget.selectedMonth, widget.selectedDay);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '일정 등록',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizeBoxH20,
            Row(
              children: [
                Text(
                  '일정',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 20,
                  height: 20,
                  color: Color(0xff2e2288),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    controller: schaduleCon,
                    decoration: InputDecoration(
                        hintText: '일정을 입력하세요', border: InputBorder.none),
                  ),
                )
              ],
            ),
            SizeBoxH10,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '일시',
                  style: TextStyle(fontSize: 20, height: 2),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          '시작',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Center(
                                child: Text(startDay != null
                                    ? startDay.toString().split(' ')[0]
                                    : selectedDate.toString().split(' ')[0])),
                          ),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: startDay != null
                                  ? startDay!
                                  : lastDay == null
                                      ? selectedDate
                                      : selectedDate.isAfter(lastDay!)
                                          ? lastDay!
                                          : selectedDate,
                              firstDate: DateTime(2020),
                              lastDate:
                                  lastDay == null ? DateTime(2030) : lastDay!,
                              // lastDate: lastDay=null ? DateTime(2030) : lastDay,
                            ).then((value) {
                              setState(() {
                                startDay = value;
                              });
                            });
                          },
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          '종료',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Center(
                                child: Text(lastDay != null
                                    ? lastDay.toString().split(' ')[0]
                                    : selectedDate.toString().split(' ')[0])),
                          ),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: lastDay != null
                                  ? lastDay!
                                  : startDay == null
                                      ? selectedDate
                                      : selectedDate.isBefore(startDay!)
                                          ? startDay!
                                          : selectedDate,
                              firstDate:
                                  startDay == null ? DateTime(2020) : startDay!,
                              lastDate: DateTime(2030),
                            ).then((value) {
                              setState(() {
                                lastDay = value;
                              });
                            });
                          },
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            SizeBoxH40,
            Row(
              children: [
                Text(
                  '알림',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    decoration: BoxDecoration(
                        color: Colors.grey[300], border: Border.all()),
                    child: Text(
                      '구현 안 됨',
                      style: TextStyle(color: Colors.grey[600]),
                    )),
              ],
            ),
            SizeBoxH30,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // controller.toDoList[startDayAdd.toString().split(' ')[0]] = '일정 추가';
                    if (startDay != null && lastDay != null) {
                      startDayAdd = startDay!;
                      lastDayAdd = lastDay!;
                      widget.toDoList[startDayAdd.toString().split(' ')[0]] = '일정 추가';
                      widget.todoColor[startDayAdd.toString().split(' ')[0]] = Color(0xff2e2288);
                      print(startDayAdd.toString());
                      Get.back();
                    } else if (startDay == null && lastDay == null) {
                      startDayAdd = selectedDate;
                      lastDayAdd = selectedDate;
                      widget.toDoList[startDayAdd.toString().split(' ')[0]] = '일정 추가';
                      widget.todoColor[startDayAdd.toString().split(' ')[0]] = Color(0xff2e2288);
                      print(startDayAdd.toString());
                      Get.back();
                    } else if (startDay == null
                        ? lastDay!.isBefore(selectedDate) == false
                        : startDay!.isAfter(selectedDate) == false) {
                      lastDay == null
                          ? startDayAdd = startDay!
                          : lastDayAdd = lastDay!;
                      lastDay == null
                          ? lastDayAdd = selectedDate
                          : startDayAdd = selectedDate;
                      widget.toDoList[startDayAdd.toString().split(' ')[0]] = '일정 추가';
                      widget.todoColor[startDayAdd.toString().split(' ')[0]] = Color(0xff2e2288);
                      print(startDayAdd.toString());
                      Get.back();
                    } else {
                      Get.dialog(AlertDialog(
                        title: Text(
                          '날짜를 잘못입력하셨습니다.',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ));
                    }
                  },
                  child: Text('일정 추가하기'),
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
                  child: Text(
                    '취소',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[300]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
