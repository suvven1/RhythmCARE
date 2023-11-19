import 'package:get/get.dart';

class MypageController extends GetxController {
  static MypageController get to => Get.find();

  // 프로필 사진 정보
  RxList<int> imageData = <int>[].obs;

  // 닉네임 정보
  RxString nick = "RhythmCARE".obs;

  // 보호자 정보
  // RxString mem_name = "김보호".obs;
  // RxString mem_phone = "010-2354-1234".obs;
  // RxString mem_birthdate = "1990-02-04".obs;
  // RxString mem_id = "mana".obs;
  // RxString mem_pw = "********".obs;
  RxMap<String, String> infomationGuard = <String, String>{
    "이름": "김보호",
    '휴대폰번호': "010-2354-1234" ,
    '생년월일': "1990-02-04",
    '아이디': "RhythmCARE",
    '비밀번호': "********"
  }.obs;

  // 기기 사용자 정보
  // RxString user_name = "이사용".obs;
  // RxString user_phone = "010-2345-4321".obs;
  // RxString user_birthdate = "1958-05-04".obs;
  RxMap<String, String> informationUser = <String, String>{
    "이름": "이사용",
    '휴대폰번호': "010-2345-4321" ,
    '생년월일': "1958-05-04",
  }.obs;

  // 뱃지 정보
  RxList<String> badgeData = <String>[].obs;


  void setUserData(Map userData) {

      // 프로필 사진 정보
    List<int> img = [];
    if(userData["mem_profile_img"]?["data"] != null){
      img = List<int>.from(userData["mem_profile_img"]["data"]);
    }
      imageData.assignAll(img);

      // 닉네임 정보
      nick.value = userData["mem_nick"];

      // 보호자 정보
      infomationGuard.value = {
        "이름": userData["mem_name"].toString(),
        '휴대폰번호': userData["mem_phone"].toString(),
        '생년월일': userData["mem_birthdate"].toString(),
        '아이디': userData["mem_id"].toString(),
      };

      // 기기사용자 정보
      informationUser.value= {
        '이름': userData["user_name"].toString(),
        '휴대폰번호': userData["user_phone"].toString() ,
        '생년월일': userData["user_birthdate"].toString(),
      };

      // 뱃지 정보
      List<String> badge = List<String>.from(userData["badge"]);
      badgeData.assignAll(badge);
  }
}
