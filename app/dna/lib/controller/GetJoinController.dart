import 'package:get/get.dart';

class JoinController extends GetxController {
  static JoinController get to => Get.find();

  RxMap JoinData = {}.obs;

  // 회원가입 정보
  String id = "";
  String pw = "";
  String nick = "";

  void setLoginData(List<String> loginData) {
    id = loginData[0];
    pw = loginData[1];
    nick = loginData[2];
  }
}
