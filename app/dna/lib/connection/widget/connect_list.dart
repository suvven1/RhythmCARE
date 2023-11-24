import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/GetConnectionController.dart';

ConnectionController connect = Get.put(ConnectionController());

connect_list(scanList) {
  return Column(
    children: [
      SizedBox(height: 10,),
      Text("연결 가능한 기기 목록", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
      Expanded(
        child: ListView.builder(
            itemCount: scanList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  connect.startConnect(scanList[index]);
                },
                child: Card(
                  margin: EdgeInsets.all(1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(scanList[index])
                  ),
                ),
              );
            }),
      ),
    ],
  );
}
