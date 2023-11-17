import 'package:get/get.dart';

class JoinController extends GetxController {
  static JoinController get to => Get.find();

  RxMap JoinData = {}.obs;

  // 회원가입 정보
  String id = "";
  String pw = "";
  RxString mName = "".obs;
  String nick = "";
  RxString mBirth = "".obs;
  RxString mGender = "".obs;
  RxString mPhone = "".obs;
  RxString uName = "".obs;
  RxString uBirth = "".obs;
  RxString uGender = "".obs;
  RxString uPhone = "".obs;

  void setLoginData(List<String> loginData) {
    id = loginData[0];
    pw = loginData[1];
    nick = loginData[2];
  }
}
