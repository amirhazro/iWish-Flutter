import 'package:get/get.dart';
import 'package:iwish_flutter/modules/home/models/home_dashboard_response_model.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxString profilePicture = ''.obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      print(Get.arguments['profileData']);
      if (Get.arguments['profileData'] != null) {
        TopShoppers obj = TopShoppers.fromJson(Get.arguments['profileData']);
        profilePicture.value = obj.picture ?? '';
      }
    }
    super.onInit();
  }
}
