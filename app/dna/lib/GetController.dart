import 'package:dna/home/tiredPage.dart';
import 'package:get/get.dart';

class ReactiveController extends GetxController {
  static ReactiveController get to => Get.find();
  // 심박수,
  RxInt hearBeatNum = 100.obs;
  RxInt stressValue = 0.obs;
  RxInt tiredValue = 0.obs;
  RxBool stressHigh = false.obs;
  RxBool tiredHigh = false.obs;

  get stressPercent => stressValue.value/100;
  get tiredPercent => tiredValue.value/100;

  @override
  void onInit(){
    // 1초마다 심박수의 변동여부 판단 후, 변동 시 콜백함수 실행
    interval(stressValue, (_){
      if(stressValue>70){
        stressHigh = true.obs;
        print('스트레스 높음');
      }else{
        stressHigh = false.obs;
        print('스트레스 낮음');
      }
    },
    time: Duration(seconds: 1),
    );
    interval(tiredValue, (_) {
      if(tiredValue>70){
        tiredHigh = true.obs;
        print('피로도 높음');
      }else{
        tiredHigh = false.obs;
        print('피로도 낮음');
      }
    },
      time: Duration(seconds: 1),
    );
  }

}