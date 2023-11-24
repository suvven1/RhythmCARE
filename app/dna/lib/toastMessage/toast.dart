import 'package:flutter/services.dart';


const MethodChannel platform = MethodChannel('rhythm_method');

void showToast(text) async {
  try{
    await platform.invokeMethod("showToast", {'text': text});
  } on PlatformException catch (e) {
    print(e);
  }
}
