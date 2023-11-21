import 'dart:io';
import 'dart:typed_data';

import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class profileImage extends StatefulWidget {
  const profileImage({Key? key, required this.imageData}) : super(key: key);

  final List<dynamic> imageData;

  @override
  State<profileImage> createState() => _profileImageState();
}

class _profileImageState extends State<profileImage> {
  // db로부터 불러온 이미지
  late List<int> img;
  // 사진 또는 갤러리로부터 불러온 이미지
  Uint8List? uint8list;
  List<int>? _imageList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    img = List<int>.from(widget.imageData);
  }

  //ImagePicker 초기화
  final ImagePicker picker = ImagePicker();

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      await getUint8list(File(XFile(pickedFile.path).path));
    }
  }

  Future<Uint8List> getUint8list (File file) async {
    var result = await FlutterImageCompress.compressWithFile(
        file.absolute.path
    );
    uint8list = result;
    _imageList = uint8list!.toList();
    return result!;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.dialog(Dialog(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: () async{
                      await getImage(ImageSource.camera);
                      setState(() {
                        uint8list = uint8list;
                        if(uint8list != null){
                          _imageList = uint8list!.toList();
                        }
                      });
                      Get.back();
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
                    setState(() {
                      uint8list = uint8list;
                      Get.back();
                    });
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
        ));
      },
      style: TextButton.styleFrom(
        iconColor: Colors.grey,
        padding: EdgeInsets.zero,
      ),
      child: Stack(clipBehavior: Clip.none, children: [
        ClipOval(
            child: uint8list != null
                ? Image.memory(
                    Uint8List.fromList(uint8list!),
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.35,
                    fit: BoxFit.cover,
                  )
                : widget.imageData.isNotEmpty
                    ? Image.memory(
                        Uint8List.fromList(img),
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.width * 0.35,
                      )
                    : Image.asset(
                        'image/User.png',
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.width * 0.35,
                      )),
        Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.25,
              left: MediaQuery.of(context).size.width * 0.24),
          child: ClipOval(
            child: Container(
              color: Colors.white,
              child: Icon(
                Icons.change_circle,
                size: MediaQuery.of(context).size.width * 0.1,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
