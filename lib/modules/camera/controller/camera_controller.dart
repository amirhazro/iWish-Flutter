import 'dart:io';

import 'package:camera/camera.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:iwish_flutter/global_controller/global_controller.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/custom_popup.dart';
import 'package:iwish_flutter/widgets/show_captured_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraViewController extends GetxController {
  late CameraController cameraController;
  late Future<void> _initializeControllerFuture;
  CameraDescription get camera => cameraController.description;
  RxString title = ''.obs;
  File? imageFront;
  File? imageBack;

  @override
  void onInit() async {
    title.value = AppLocalizations.of(Get.context!)!.scanFrontSide;

    cameraController = CameraController(
        Get.find<GlobalController>().availableCam.first, ResolutionPreset.high,
        enableAudio: false, imageFormatGroup: ImageFormatGroup.yuv420);

    await cameraController.initialize();
    update();
    super.onInit();
  }

  Future<void> initializeController() async {
    await _initializeControllerFuture;
  }

  @override
  void onClose() async {
    await cameraController.dispose();
    super.dispose();
  }

  void moveToNextImage() async {
    try {
      await cameraController.initialize();
      XFile file = await cameraController.takePicture();

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: ThemeColors().primaryColorOne,
            toolbarWidgetColor: ThemeColors().white,
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
            hideBottomControls: true,
            showCropGrid: false,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      if (croppedFile != null) {
        CustomPopup.showCustomWidgetDialog(
          Get.context!,
          ShowCapturedImage(
            image: XFile(croppedFile.path),
            onCancel: () {
              Get.back();
            },
            onConfirm: () {
              Get.back();
              if (imageFront == null) {
                imageFront = File(croppedFile.path);
                title.value = AppLocalizations.of(Get.context!)!.scanBackSide;
                return;
              } else {
                imageBack ??= File(croppedFile.path);
              }

              if (imageFront != null && imageBack != null) {
                requestSubmitIdVarification();
              }
            },
          ),
        );
      }
    } catch (e) {
      e.printError();
    }
  }

  //region API Call
  void requestSubmitIdVarification() {
    print("Information Submitted");
    Get.back();
  }
  //endregion
}
