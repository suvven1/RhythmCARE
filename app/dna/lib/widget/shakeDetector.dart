import 'package:dna/widget/shakeDialog.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';

bool isShakeOpen = false;

ShakeDetector detector = ShakeDetector.waitForStart(
  onPhoneShake: () async {
    if (isShakeOpen == false) {
      isShakeOpen = true;
      await Get.dialog(
        shakeDialog(),
      );
      isShakeOpen = false;
    }
  },
  minimumShakeCount: 1,
  shakeSlopTimeMS: 500,
  shakeCountResetTime: 3000,
  shakeThresholdGravity: 2,
  // 1 : 정지한 상태에서도 계속 뜸
);