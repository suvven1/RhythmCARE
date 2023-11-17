import 'package:dna/controller/GetXCalendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class titleWidget extends StatelessWidget {
  const titleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final GetXCalendar controller = Get.put(GetXCalendar());
    return GetX<GetXCalendar>(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: ButtonStyle(

              ),
              child: Icon(
                color: Colors.black,
                Icons.chevron_left_sharp,
                size: 50,
              ),
              onPressed: () {
                if(controller.selectedMonth == 1){
                  controller.selectedYear.value--;
                  controller.selectedMonth.value = 12;
                }else {
                  controller.selectedMonth--;
                }
              },
            ),
            Text(
              ' ${controller.selectedYear}.${controller.selectedMonth}',
              style: TextStyle(fontSize: 30),
            ),
            TextButton(
              child: Icon(
                color: Colors.black,
                Icons.chevron_right_sharp,
                size: 50,
              ),
              onPressed: () {
                if(controller.selectedMonth == 12){
                  controller.selectedYear.value++;
                  controller.selectedMonth.value = 1;
                }else {
                  controller.selectedMonth++;
                }
              },
            )
          ],
        ),
      );
    });
  }
}
