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
  });

  final selectedYear;
  final selectedMonth;
  final selectedDay;
  final toDoList;

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

  String selectedColor = '0xffeb6867';
  int selectedColorBorder = 1;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '새로운 일정 추가',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizeBoxH20,
            Row(
              children: [
                Text(
                  '색상',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Table(
                    children: [
                      TableRow(children: [
                        TextButton(
                          onPressed: () {
                            selectedColor = '0xffeb6867';
                            setState(() {
                            selectedColorBorder = 1;
                            });
                          },
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Color(0xffeb6867),
                              border: selectedColorBorder == 1 ? Border.all(width: 3, color: Colors.black) : null,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            selectedColor = '0xfff39a47';
                            setState(() {
                            selectedColorBorder = 2;
                            });
                          },
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Color(0xfff39a47),
                              border: selectedColorBorder == 2 ? Border.all(width: 3, color: Colors.black) : null,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            selectedColor = '0xff47b794';
                            setState(() {
                            selectedColorBorder = 3;
                            });
                          },
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Color(0xff47b794),
                              border: selectedColorBorder == 3 ? Border.all(width: 3, color: Colors.black) : null,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            selectedColor = '0xff1eb2d4';
                            setState(() {
                            selectedColorBorder = 4;
                            });
                          },
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Color(0xff1eb2d4),
                              border: selectedColorBorder == 4 ? Border.all(width: 3, color: Colors.black) : null,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            selectedColor = '0xff762fc1';
                            setState(() {
                            selectedColorBorder = 5;
                            });
                          },
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Color(0xff762fc1),
                              border: selectedColorBorder == 5 ? Border.all(width: 3, color: Colors.black) : null,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
              ],
            ),
            SizeBoxH10,
            Row(
              children: [
                Text(
                  '내용',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 20),
                      controller: schaduleCon,
                      decoration: InputDecoration(
                        hintText: '일정을 입력하세요',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizeBoxH10,
            Row(
              children: [
                Text(
                  '시작',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(7)),
                    child: TextButton(
                      child: Center(
                          child: Text(
                        startDay != null
                            ? startDay.toString().split(' ')[0]
                            : selectedDate.toString().split(' ')[0],
                        style: TextStyle(fontSize: 25),
                      )),
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
                          lastDate: lastDay == null ? DateTime(2030) : lastDay!,
                          // lastDate: lastDay=null ? DateTime(2030) : lastDay,
                        ).then((value) {
                          setState(() {
                            startDay = value;
                          });
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizeBoxH10,
            Row(
              children: [
                Text(
                  '종료',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(7)),
                    child: TextButton(
                      child: Center(
                          child: Text(
                            lastDay != null
                                ? lastDay.toString().split(' ')[0]
                                : selectedDate.toString().split(' ')[0],
                            style: TextStyle(fontSize: 25),
                          )),
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
                    ),
                  ),
                ),
              ],
            ),
            SizeBoxH20,
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
                      widget.toDoList.add([
                        schaduleCon.text,
                        startDayAdd.toString().split(' ')[0],
                        lastDayAdd.toString().split(' ')[0],
                        selectedColor
                      ]);
                      Get.back();
                    } else if (startDay == null && lastDay == null) {
                      startDayAdd = selectedDate;
                      lastDayAdd = selectedDate;
                      widget.toDoList.add([
                        schaduleCon.text,
                        startDayAdd.toString().split(' ')[0],
                        lastDayAdd.toString().split(' ')[0],
                        selectedColor
                      ]);
                      Get.back();
                    } else if (startDay == null
                        ? lastDay!.isBefore(selectedDate) == false
                        : startDay!.isAfter(selectedDate) == false) {
                      lastDay == null
                          ? startDayAdd = startDay!
                          : lastDayAdd = lastDay!;
                      startDay == null
                          ? startDayAdd = selectedDate
                          : lastDayAdd = selectedDate;
                      widget.toDoList.add([
                        schaduleCon.text,
                        startDayAdd.toString().split(' ')[0],
                        lastDayAdd.toString().split(' ')[0],
                        selectedColor
                      ]);
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
                  child: SizedBox(height: 45, child: Center(child: Text('일정 추가하기', style: TextStyle(fontSize: 20),))),
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
                        '취소',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
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
