import 'package:get/get.dart';

class MypageController extends GetxController {
  static MypageController get to => Get.find();

  RxMap userData = {}.obs;
  // 사용자 이미지, 닉네임 정보
  RxList<int> imageData = RxList<int>();
  RxString nick = "nick".obs;

  // 보호자 정보
  RxString managerName = "manager".obs;
  RxString managerHP = "010-1111-2222".obs;
  RxString managerBD = "2000-01-01".obs;
  RxString managerID = "mana".obs;
  RxString managerPW = "********".obs;

  // 기기 사용자 정보
  RxString userName = "user".obs;
  RxString userHP = "010-3333-4444".obs;
  RxString userBD = "2000-01-01".obs;

  // 뱃지 정보
  RxList<String> badgeData = <String>[].obs;

  // get stressText => stressValue>60 ? '높은':'낮은';
  // get stressImage => stressValue>60 ? 'image/heart_bad.png':'image/heart_good.png';
  //
  // get tiredText => tiredValue>60 ? '높은':'낮은';
  // get tiredImage => tiredValue>60 ? 'image/heart_bad.png':'image/heart_good.png';
  void setImgData(List<int> imgData ) {
    imageData.assignAll(imgData);

  }

  void setBadgeData(List<String>badData){
    badgeData.assignAll(badData);
    print(badgeData);
  }
  void setUserData(Map data) {
    // 유저 전체 데이터
    userData.value = data["loginResult"];

    // 이미지, 닉네임
    if(userData["data"]["img"] != null){
      List<int> img = List<int>.from(userData["data"]["img"]["data"]);
      setImgData(img);
    }

    if(userData["data"]["badgeData"] != null){
      List<String> badge = List<String>.from(userData["badgeData"]);
      setBadgeData(badge);
    }

    print("first Data : ${badgeData}");
    print("imgData : ${imageData}");
    nick.value = userData["nick"];

    // 보호자 정보
    managerName.value = userData["data"]["manager_name"];
    managerHP.value = userData["data"]["manager_hp"];
    managerBD.value = userData["data"]["manager_bd"];
    managerID.value = userData["data"]["manager_id"];
    managerPW.value = userData["data"]["password"];

    // 기기사용자 정보
    userName.value = userData["data"]["user_name"];
    userHP.value = userData["data"]["user_hp"];
    userBD.value = userData["data"]["user_bd"];
  }

  @override
  void onInit() {
    // // 1초마다 피로도 값 확인 후, 콜백함수 실행
    // interval(tiredValue, (_) {
    //   if (tiredValue > 60) {
    //     print('피로도 높음');
    //   } else {
    //     print('피로도 낮음');
    //   }
    // },
    //   time: Duration(seconds: 1),
    // );
  }
}