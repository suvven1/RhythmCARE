
import 'dart:convert';
import 'dart:typed_data';

import 'package:dna/toastMessage/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../../widget/sizeBox.dart';


class changeImgDialog extends StatefulWidget {
  const changeImgDialog({super.key});

  @override
  State<changeImgDialog> createState() => _changeImgDialogState();
}

class _changeImgDialogState extends State<changeImgDialog> {
  Uint8List? uint8list;

  //ImagePicker 초기화
  final ImagePicker picker = ImagePicker();

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      uint8list = await pickedFile.readAsBytes();
      cropImg(uint8list!);
    }
  }

  // 이미지 압축 함수
  void cropImg(Uint8List beforeList) async {
    var croppedUint8List= await FlutterImageCompress.compressWithList(
      beforeList,
      minWidth: 500,
      minHeight: 500,
      quality: 50
    );

    changeImg(croppedUint8List);
  }




  // 이미지 변경 함수
  void changeImg(Uint8List imageBytes) async {
    final loginDataStorage = await SharedPreferences.getInstance();
    final userId = loginDataStorage.getString('id') ?? '';

    // 서버 엔드포인트 URL
    var url = Uri.parse('http://115.95.222.206:80/user/changeImg');

    // Multipart 요청 생성
    var request = http.MultipartRequest('POST', url)
      ..fields['id'] = userId
      ..files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'image.png',
        contentType: MediaType('image', '*'), // 이 부분 수정
      ));

    try {
      // 요청 보내기
      var response = await http.Response.fromStream(await request.send());

      // 서버 응답 출력
      var resData = jsonDecode(response.body)["chageImgResult"];
      if(resData){
        showToast("이미지 변경이 완료되었습니다.");
        Get.back(result: true);
      }else{
        showToast("[네트워크 에러] 이미지 변경이 실패 하였습니다.");
        Get.back(result: true);
      }
    } catch (error) {
      // 에러 처리
      print('Error uploading image: $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await getImage(ImageSource.camera);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2e2288),
                    minimumSize: Size(150, 70)),
                child: Text(
                  '카메라',
                  style: TextStyle(fontSize: 30),
                )),
            SizeBoxH20,
            ElevatedButton(
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2e2288),
                  minimumSize: Size(150, 70)),
              child: Text(
                '갤러리',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}