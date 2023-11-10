import 'package:get/get.dart';

class ReactiveController extends GetxController {
  static ReactiveController get to => Get.find();

  // 심박수, 스트레스/피로도 수치
  RxInt hearBeatNum = 100.obs;
  RxInt stressValue = 0.obs;
  RxInt tiredValue = 0.obs;
  RxBool stressHigh = false.obs;
  RxBool tiredHigh = false.obs;

  get stressFace => stressHigh.value ? '높은':'낮은';
  get stressImage => stressHigh.value ? 'image/heart_bad.png':'image/heart_good.png';

  get tiredFace => tiredHigh.value ? '높은':'낮은';
  get tiredImage => tiredHigh.value ? 'image/heart_bad.png':'image/heart_good.png';


  @override
  void onInit() {
    // 1초마다 스트레스 값 확인 후, 콜백함수 실행
    interval(stressValue, (_) {
      if (stressValue > 70) {
        stressHigh = true.obs;
        print('스트레스 높음');
      } else {
        stressHigh = false.obs;
        print('스트레스 낮음');
      }
    },
      time: Duration(seconds: 1),
    );
    // 1초마다 피로도 값 확인 후, 콜백함수 실행
    interval(tiredValue, (_) {
      if (tiredValue > 70) {
        tiredHigh = true.obs;
        print('피로도 높음');
      } else {
        tiredHigh = false.obs;
        print('피로도 낮음');
      }
    },
      time: Duration(seconds: 1),
    );
  }
}