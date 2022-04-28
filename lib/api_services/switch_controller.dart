import 'package:get/get.dart';

class SwitchController extends GetxController {
  var rr = false.obs;
  isSwitchOn(Value) {
    rr.value = Value;
  }
}
