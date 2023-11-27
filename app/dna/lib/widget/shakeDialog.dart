import 'package:dna/controller/GetMyPageController.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class shakeDialog extends StatefulWidget {
  const shakeDialog({Key? key}) : super(key: key);

  @override
  State<shakeDialog> createState() => _shakeDialogState();
}

class _shakeDialogState extends State<shakeDialog> {
  final MypageController mypageController = Get.put(MypageController());
  late String? phoneNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNumber = mypageController.infomationGuard['휴대폰번호'];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(150)),
      child: Container(
        height: MediaQuery.of(context).size.width*0.77,
        child: ElevatedButton(
          onPressed: () async{
            if(phoneNumber != null) {
              if (await canLaunchUrl(Uri(scheme: 'tel', path: phoneNumber))) {
                await launchUrl(Uri(scheme: 'tel', path: phoneNumber));
              } else {
                throw 'Could not launch';
              }
            }else{
              showToast('보호자 번호를 입력하세요.');
            }
          },
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.yellowAccent,
              backgroundColor: Colors.redAccent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '보호자에게',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                '연락하기',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
