import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/interest/models/interst_chip_modal.dart';
import 'package:iwish_flutter/modules/interest/repository/interest_repository.dart';
import 'package:iwish_flutter/modules/signin/models/countries_model.dart';
import 'package:iwish_flutter/modules/signin/repository/signin_signup_repository.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/utils.dart';

class ViewWishController extends GetxController {
  RxBool isLoading = false.obs;

  RxBool isFirstImageLoading = false.obs;
  RxBool isSecondImageLoading = false.obs;
  RxBool isThirdImageLoading = false.obs;

  Rx<XFile?> imageOne = Rx<XFile?>(null);
  Rx<XFile?> imageTwo = Rx<XFile?>(null);
  Rx<XFile?> imageThree = Rx<XFile?>(null);

  RxString strQuantity = "1".obs;
  RxString strDesiredCountry = "Select country".obs;
  int desiredCountryId = -1;
  RxString strCategory = "Select category".obs;
  int? trendingWishCategoryId;
  int wishlistCategoryId = -1;
  int addressId = -1;
  int? varifiedTravelersCount;
  bool isEditFlow = false;
  int? id;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productUrlController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  RxList<CountryViewModel> lstCountriesData = <CountryViewModel>[].obs;
  RxList<InterestChipModal> lstInterestData = <InterestChipModal>[].obs;

  @override
  void onInit() async {
    await requestGetCountriesList();
    await requestGetInterestList();
    if (Get.arguments != null) {
      id = Get.arguments['wishId'] ?? -1;
      strQuantity.value = '${(Get.arguments['quantity'] ?? '1')}';
      productUrlController.text = Get.arguments['url'] ?? '';
      productNameController.text = Get.arguments['productName'] ?? '';
      productDescriptionController.text = Get.arguments['productDesc'] ?? '';
      if (Get.arguments['countryId'] != null) {
        desiredCountryId = Get.arguments['countryId'];
        strDesiredCountry.value = lstCountriesData
                .where((p0) => p0.countryId == Get.arguments['countryId'])
                .first
                .countryName ??
            '';
      }
      if (Get.arguments['categoryId'] != null) {
        wishlistCategoryId = Get.arguments['categoryId'];
        strCategory.value = lstInterestData
                .where((p0) => p0.id == Get.arguments['categoryId'])
                .first
                .title ??
            '';
      }

      if (Get.arguments['wishRefId'] != null) {
        trendingWishCategoryId = Get.arguments['wishRefId'];
      }

      if (Get.arguments['pictureOne'] != null) {
        isFirstImageLoading.value = true;
        File tempFile = await Utils.downloadAndSaveImage(
            '${APIConfiguration.baseImage}${Get.arguments['pictureOne']}',
            "iwishTempImageOne");
        imageOne.value = XFile(tempFile.path);
        isFirstImageLoading.value = false;
      }
      if (Get.arguments['pictureTwo'] != null) {
        isSecondImageLoading.value = true;
        File tempFile = await Utils.downloadAndSaveImage(
            '${APIConfiguration.baseImage}${Get.arguments['pictureTwo']}',
            "iwishTempImageTwo");
        imageTwo.value = XFile(tempFile.path);
        isSecondImageLoading.value = false;
      }
      if (Get.arguments['pictureThree'] != null) {
        isThirdImageLoading.value = true;
        File tempFile = await Utils.downloadAndSaveImage(
            '${APIConfiguration.baseImage}${Get.arguments['pictureThree']}',
            "iwishTempImageThree");
        imageThree.value = XFile(tempFile.path);
        isThirdImageLoading.value = false;
      }
    }
    super.onInit();
  }

  //Region API
  Future<void> requestGetCountriesList() async {
    isLoading.value = true;
    try {
      var res = await SignInSignUpRepository().getCountriesList('');

      if (res.isNotEmpty) {
        lstCountriesData.addAll(res);
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestGetInterestList() async {
    isLoading.value = true;
    try {
      var res = await InterestRepository().getInterestList();

      lstInterestData.addAll(res);
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }
}
