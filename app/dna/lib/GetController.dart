import 'package:get/get.dart';

class ReactiveController extends GetxController {
  static ReactiveController get to => Get.find();

  // 심박수, 스트레스/피로도 수치
  RxInt hearBeatNum = 100.obs;
  RxInt stressValue = 0.obs;
  RxInt tiredValue = 0.obs;

  get stressText => stressValue>60 ? '높은':'낮은';
  get stressImage => stressValue>60 ? 'image/heart_bad.png':'image/heart_good.png';

  get tiredText => tiredValue>60 ? '높은':'낮은';
  get tiredImage => tiredValue>60 ? 'image/heart_bad.png':'image/heart_good.png';


  @override
  void onInit() {
    // 1초마다 스트레스 값 확인 후, 콜백함수 실행
    interval(stressValue, (_) {
      if (stressValue > 60) {
        print('스트레스 높음');
      } else {
        print('스트레스 낮음');
      }
    },
      time: Duration(seconds: 1),
    );
    // 1초마다 피로도 값 확인 후, 콜백함수 실행
    interval(tiredValue, (_) {
      if (tiredValue > 60) {
        print('피로도 높음');
      } else {
        print('피로도 낮음');
      }
    },
      time: Duration(seconds: 1),
    );
  }
}