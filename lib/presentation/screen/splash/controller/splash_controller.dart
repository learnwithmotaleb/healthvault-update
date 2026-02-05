import 'dart:async';

import 'package:get/get.dart';

class SplashController extends GetxController {
  Timer? _timer;

  void start({required String nextRoute}) {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 5), () {
      Get.offAllNamed(nextRoute);
    });
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
