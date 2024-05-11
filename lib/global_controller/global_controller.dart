import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/global_controller/socket_controller.dart';
import 'package:iwish_flutter/modules/home/controller/home_controller.dart';
import 'package:iwish_flutter/modules/wishes/controller/wishes_controller.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/keys.dart';

class GlobalController extends GetxController {
  RxString userName = ' User'.obs;
  Rx<String?> imagePath = Rx<String?>(null);
  String route = '';
  late List<CameraDescription> availableCam;
  late SocketController socketController;

  Future<void> updateUserData() async {
    String? name = await StorageService().readString(Keys.UserFirstName);

    if (name != null) {
      if (name.isEmpty) {
        userName.value = ' User';
      } else {
        userName.value = ' $name';
      }
    } else {
      userName.value = ' User';
    }

    imagePath.value =
        '${(await StorageService().readString(Keys.UserPicture))}';
  }

  Future<void> updateWishesList() async {
    if (Get.isRegistered<WishesController>()) {
      Get.find<WishesController>().pagingController.itemList?.clear();
      Get.find<WishesController>().requestGetWishesList(1);
    }
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().requestGetHomeDashBoadrdData();
    }
  }

  @override
  void onInit() async {
    updateUserData();
    socketController = Get.find<SocketController>();
    availableCam = await availableCameras();

    super.onInit();
  }
}
