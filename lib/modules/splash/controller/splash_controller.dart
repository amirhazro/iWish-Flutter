import 'package:get/get.dart';

class SplashController extends GetxController {
  RxBool isAppear = false.obs;

  @override
  void onInit() {
    super.onInit();
    appearViews();
  }

  void appearViews() {
    Future.delayed(const Duration(seconds: 2), () {
      isAppear.value = true;
    });
  }
}
