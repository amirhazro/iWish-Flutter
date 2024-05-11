import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/spoken_language_modal.dart';

class SpokenLanguageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxString selectedLanguage = ''.obs;
  RxList<SpokenLanguageModal> lstLanguageData = <SpokenLanguageModal>[].obs;

  RxBool isVisible = false.obs;

  late Rx<AnimationController> animationController;
  late Rx<Animation<Offset>> animation;

  showHideDropDown() {
    if (lstLanguageData.isNotEmpty) {
      isVisible.value = !isVisible.value;
      if (isVisible.value) {
        animationController.value.forward();
      } else {
        animationController.value.reverse();
      }
    }
  }

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    ).obs;
    animation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    )
        .animate(
          CurvedAnimation(
            parent: animationController.value,
            curve: Curves.easeInOut,
          ),
        )
        .obs;
    super.onInit();
  }

  void handleSelection(int index) {
    lstLanguageData[index].isSelected.value =
        !lstLanguageData[index].isSelected.value;

    selectedLanguage.value = '';

    if (lstLanguageData.any((element) => element.isSelected.value)) {
      selectedLanguage.value = lstLanguageData
          .where((element) => element.isSelected.value)
          .map((obj) => obj.langugaeName)
          .join(', ');
    } else {
      selectedLanguage.value = '';
    }
  }

  String getSelectedLangugaeIds() {
    return lstLanguageData
        .where((element) => element.isSelected.value)
        .map((obj) => obj.id)
        .join(', ');
  }
}
