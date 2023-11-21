import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/GetConnectionController.dart';

List<String> connectList = [];

void setItem(){
  for(int i = 0; i < 10; i++){
    connectList.add('Smart_watch_${i+1}');
  }
}

connect_list() {
  setItem();
  return Column(
    children: [
      SizedBox(height: 10,),
      Text("연결 가능한 기기 목록", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
      Expanded(
        child: ListView.builder(
            itemCount: connectList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                },
                child: Card(
                  margin: EdgeInsets.all(1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(connectList[index])
                  ),
                ),
              );
            }),
      ),
    ],
  );
}
