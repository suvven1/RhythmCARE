import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../notification/emergency_notification.dart';

class NoticeController extends GetxController {
  static NoticeController get to => Get.find();

  void requestNotificationPermissions(context) async {
    //알림 권한 요청
    final status = await NotificationService().requestNotificationPermissions();

    if (status.isDenied && context.mounted) {
      showDialog(
        // 알림 권한이 거부되었을 경우 다이얼로그 출력
        context: context,
        builder: (context) => AlertDialog(
          title: Text('알림 권한이 거부되었습니다.'),
          content: Text('알림을 받으려면 앱 설정에서 권한을 허용해야 합니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('설정'), //다이얼로그 버튼의 죄측 텍스트
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings(); //설정 클릭시 권한설정 화면으로 이동
              },
            ),
            TextButton(
              child: Text('취소'), //다이얼로그 버튼의 우측 텍스트
              onPressed: () => Navigator.of(context).pop(), //다이얼로그 닫기
            ),
          ],
        ),
      );
    }
  }

}
