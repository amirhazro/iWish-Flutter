import 'package:get/get.dart';
import 'package:iwish_flutter/global_controller/global_controller.dart';

class BottomNavigationController extends GetxController {
  var tabIndex = 0.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    Get.find<GlobalController>();
    super.onInit();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onClose() {
    if (Get.isRegistered<GlobalController>()) {
      Get.delete<GlobalController>();
    }
    super.onClose();
  }
}
