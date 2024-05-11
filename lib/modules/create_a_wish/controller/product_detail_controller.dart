import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwish_flutter/global_controller/global_controller.dart';
import 'package:iwish_flutter/modules/create_a_wish/models/address_list_view_model.dart';
import 'package:iwish_flutter/modules/create_a_wish/repository/create_wish_repository.dart';
import 'package:iwish_flutter/modules/interest/models/interst_chip_modal.dart';
import 'package:iwish_flutter/modules/interest/repository/interest_repository.dart';
import 'package:iwish_flutter/modules/signin/models/countries_model.dart';
import 'package:iwish_flutter/modules/signin/repository/signin_signup_repository.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/custom_popup.dart';

import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/image_picker_bottom_sheet.dart';
import 'package:iwish_flutter/widgets/snackbar_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailController extends GetxController {
  final CreateWishRepository _repository = CreateWishRepository();

  RxBool isFirstImageLoading = false.obs;
  RxBool isSecondImageLoading = false.obs;
  RxBool isThirdImageLoading = false.obs;

  RxBool isImagesLoading = false.obs;

  RxBool isProductNameEnable = true.obs;
  RxBool isCountryEnable = true.obs;
  RxBool isUrlEnable = true.obs;
  RxBool isCategoryEnable = true.obs;
  RxBool isDescriptionEnable = true.obs;
  RxBool isImageChangeEnable = true.obs;
  RxBool isQuantityEnabled = true.obs;

  RxBool isLoading = false.obs;
  RxBool isDesiredCountryDropDownVisible = false.obs;
  RxBool isDesiredCategoryDropDownVisible = false.obs;

  Rx<String?> errorMsgProductName = Rx<String?>(null);
  Rx<String?> errorMsgCountry = Rx<String?>(null);
  Rx<String?> errorMsgCategory = Rx<String?>(null);

  Rx<XFile?> imageOne = Rx<XFile?>(null);
  Rx<XFile?> imageTwo = Rx<XFile?>(null);
  Rx<XFile?> imageThree = Rx<XFile?>(null);

  RxList<CountryViewModel> lstCountriesData = <CountryViewModel>[].obs;
  List<CountryViewModel> lstCountriesRawData = <CountryViewModel>[];
  RxList<InterestChipModal> lstInterestData = <InterestChipModal>[].obs;
  RxList<AddressListViewModel> lstAddresses = <AddressListViewModel>[].obs;

  TextEditingController searchCountryController = TextEditingController();
  RxString searchCountryHint =
      AppLocalizations.of(Get.context!)!.searchByName.obs;
  FocusNode searchFocusNode = FocusNode();

  RxString strQuantity = "1".obs;
  RxString strDesiredCountry = "Select country".obs;
  int desiredCountryId = -1;
  RxString strCategory = "Select category".obs;
  int? trendingWishCategoryId;
  int wishlistCategoryId = -1;
  RxInt addressId = 0.obs;
  int? varifiedTravelersCount;
  bool isEditFlow = false;
  int? id;
  bool isAllEditable = true;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productUrlController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  RxString productUrlHintText =
      AppLocalizations.of(Get.context!)!.enterUrlOfProduct.obs;
  RxString productNameHintText =
      AppLocalizations.of(Get.context!)!.enterProductName.obs;
  RxString productDescHintText =
      AppLocalizations.of(Get.context!)!.enterDescription.obs;

  FocusNode productNameFocusNode = FocusNode();
  FocusNode productUrlFocusNode = FocusNode();
  FocusNode productDescriptionFocusNode = FocusNode();

  @override
  void onInit() async {
    await requestGetCountriesList();
    if (!await requestGetInterestList()) return;
    await requestGetAddressList();

    if (Get.arguments != null) {
      isEditFlow = Get.arguments['isEdit'] ?? false;

      if (Get.arguments['addressId'] != null) {
        addressId.value = Get.arguments['addressId'];
      }
      if (Get.arguments['isAllEditAble'] != null) {
        isAllEditable = Get.arguments['isAllEditAble'];
      }

      if (!isAllEditable) {
        isDescriptionEnable.value = false;
        isQuantityEnabled.value = false;
      }

      if (!isEditFlow) {
        isProductNameEnable.value = false;
        isCountryEnable.value = false;
        isUrlEnable.value = false;
        isCategoryEnable.value = false;
        isImageChangeEnable.value = false;
      }

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

      isImagesLoading.value = true;
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

      isImagesLoading.value = false;
    }

    productNameController.addListener(() {
      if (productNameController.text.isNotEmpty) {
        errorMsgProductName.value = null;
      }
    });

    productNameFocusNode.addListener(onFocusTextField);
    productUrlFocusNode.addListener(onFocusTextField);
    productDescriptionFocusNode.addListener(onFocusTextField);

    searchCountryController.addListener(() {
      if (searchCountryController.text.isNotEmpty &&
          searchCountryController.text.length > 1) {
        // debouncer.call(() {
        if (lstCountriesData.isNotEmpty) {
          lstCountriesData.clear();
        }
        lstCountriesData.addAll(lstCountriesRawData
            .where((element) => element.countryName!
                .toLowerCase()
                .contains(searchCountryController.text.toLowerCase()))
            .toList());
        lstCountriesData.refresh();
        // });
      }
      if (searchFocusNode.hasFocus && searchCountryController.text.isEmpty) {
        if (lstCountriesData.isNotEmpty) {
          lstCountriesData.clear();
        }
        lstCountriesData.addAll(lstCountriesRawData);
        lstCountriesData.refresh();
      }
    });

    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        searchCountryHint.value = '';
      } else {
        searchCountryHint.value =
            AppLocalizations.of(Get.context!)!.searchByName;
      }
    });
    super.onInit();
  }

  void onFocusTextField() {
    if (productNameFocusNode.hasFocus) {
      productNameHintText.value = '';
    } else {
      productNameHintText.value =
          AppLocalizations.of(Get.context!)!.enterProductName;
    }
    if (productUrlFocusNode.hasFocus) {
      productUrlHintText.value = '';
    } else {
      productUrlHintText.value =
          AppLocalizations.of(Get.context!)!.enterUrlOfProduct;
    }
    if (productDescriptionFocusNode.hasFocus) {
      productDescHintText.value = '';
    } else {
      productDescHintText.value =
          AppLocalizations.of(Get.context!)!.enterDescription;
    }
  }

  void showImagePickerDialog(context, int pickImageIndex) async {
    CustomBottomSheet.showCustomBottomSheet(
        context,
        ImagePickerBottomSheet(
            onPickFromGallary: () => pickFromGallary(pickImageIndex),
            onPickFromCamera: () => pickFromCamera(pickImageIndex)));
  }

  void pickFromGallary(int index) async {
    Get.back();
    if (index == 1) {
      isFirstImageLoading.value = true;
    }
    if (index == 2) {
      isSecondImageLoading.value = true;
    }
    if (index == 3) {
      isThirdImageLoading.value = true;
    }

    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      requestFullMetadata: false,
    );

    if (pickedFile != null) {
      if (Utils.checkIfFileIsImageOrNot(pickedFile)) {
        if (index == 1) {
          imageOne.value = pickedFile;
          isFirstImageLoading.value = false;
        } else if (index == 2) {
          imageTwo.value = pickedFile;
          isSecondImageLoading.value = true;
        } else if (index == 3) {
          imageThree.value = pickedFile;
          isThirdImageLoading.value = true;
        }
      } else {
        SnackbarPopup.show("Only image files are allowed",
            isError: false, title: "Information");
        if (index == 1) {
          isFirstImageLoading.value = false;
        } else if (index == 2) {
          isSecondImageLoading.value = true;
        } else if (index == 3) {
          isThirdImageLoading.value = true;
        }
      }
    } else {
      if (index == 1) {
        isFirstImageLoading.value = false;
      } else if (index == 2) {
        isSecondImageLoading.value = true;
      } else if (index == 3) {
        isThirdImageLoading.value = true;
      }
    }
  }

  void pickFromCamera(int index) async {
    Get.back();
    try {
      if (index == 1) {
        isFirstImageLoading.value = true;
      }
      if (index == 2) {
        isSecondImageLoading.value = true;
      }
      if (index == 3) {
        isThirdImageLoading.value = true;
      }
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        requestFullMetadata: false,
      );

      if (pickedFile != null) {
        if (index == 1) {
          imageOne.value = pickedFile;
          isFirstImageLoading.value = false;
        } else if (index == 2) {
          imageTwo.value = pickedFile;
          isSecondImageLoading.value = true;
        } else if (index == 3) {
          imageThree.value = pickedFile;
          isThirdImageLoading.value = true;
        }
      } else {
        if (index == 1) {
          isFirstImageLoading.value = false;
        } else if (index == 2) {
          isSecondImageLoading.value = true;
        } else if (index == 3) {
          isThirdImageLoading.value = true;
        }
      }
    } on PlatformException catch (ex) {
      CustomPopup.showCustomDialog(
        Get.context!,
        'Permission denied',
        '${ex.message}',
      );
    }
  }

  void quantityIncrease() {
    int value = int.parse(strQuantity.value);
    strQuantity.value = '${value + 1}';
  }

  void quantityDecrease() {
    int value = int.parse(strQuantity.value);
    if (value > 1) {
      strQuantity.value = '${value - 1}';
    }
  }

  void handleCountrySelection(int index) {
    isDesiredCountryDropDownVisible.value =
        !isDesiredCountryDropDownVisible.value;

    strDesiredCountry.value = lstCountriesData[index].countryName ?? '';
    desiredCountryId = lstCountriesData[index].countryId;
    if (desiredCountryId != -1) {
      errorMsgCountry.value = null;
    }
    searchCountryController.text = '';
    Utils.dismissKeyboard(Get.context!);
  }

  void handleCategorySelection(int index) {
    isDesiredCategoryDropDownVisible.value =
        !isDesiredCategoryDropDownVisible.value;

    strCategory.value = lstInterestData[index].title ?? '';
    wishlistCategoryId = lstInterestData[index].id ?? -1;

    if (wishlistCategoryId != -1) {
      errorMsgCategory.value = null;
    }
  }

  void moveToOrderSummaryScreen() {
    bool isError = false;
    if (productNameController.text.isEmpty) {
      errorMsgProductName.value = "Please enter product name";
      isError = true;
    }
    if (desiredCountryId == -1) {
      errorMsgCountry.value = "Please select country";
      isError = true;
    }
    if (wishlistCategoryId == -1) {
      errorMsgCategory.value = "Please select category";
      isError = true;
    }
    if (isError) {
      return;
    }
    if (imageOne.value == null ||
        imageTwo.value == null ||
        imageThree.value == null) {
      SnackbarPopup.show("Please select all 3 images", isError: false);
      return;
    }

    Get.toNamed(Routes().getSelectAddressScreen());
  }

  String formatURL(String input) {
    if (input.startsWith('http://') || input.startsWith('https://')) {
      if (input.contains('www.')) {
        return input;
      } else {
        if (input.startsWith('https://')) {
          return input.replaceFirst('https://', 'https://www.');
        } else {
          return input.replaceFirst('http://', 'https://www.');
        }
      }
    } else {
      if (input.startsWith('www.')) {
        return 'https://$input'; // If it does, prepend "https://"
      } else {
        return 'https://www.$input';
      }
    }
  }

  void navToAddAddressScreen() async {
    bool res = await Get.toNamed(Routes().getAddressScreen(),
        arguments: {'isAddAddress': true});

    if (res) {
      if (lstAddresses.isNotEmpty) lstAddresses.clear();

      requestGetAddressList();
    }
  }

//API Region
  Future<void> requestGetCountriesList() async {
    isLoading.value = true;
    try {
      var res = await SignInSignUpRepository().getCountriesList('');

      if (res.isNotEmpty) {
        strDesiredCountry.value = res
                .firstWhere((element) =>
                    element.countryName?.toLowerCase() == 'anywhere')
                .countryName ??
            '';
        desiredCountryId = res
            .firstWhere(
                (element) => element.countryName?.toLowerCase() == 'anywhere')
            .countryId;
        lstCountriesData.addAll(res);
        lstCountriesRawData.addAll(res);
        lstCountriesData.refresh();
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> requestGetInterestList() async {
    isLoading.value = true;
    try {
      var res = await InterestRepository().getInterestList();

      lstInterestData.addAll(res);
      lstInterestData.refresh();
      return true;
    } catch (e) {
      e.printError();
      if (e.toString().contains('100')) {
        Utils.showNoInternetWarning();
      }
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestGetAddressList() async {
    isLoading.value = true;
    try {
      var res = await _repository.getAddressList();
      if (res.data != null && res.data!.isNotEmpty) {
        lstAddresses.value = res.data!
            .map((e) => AddressListViewModel(
                  id: e.id ?? 0,
                  user_id: e.userId ?? 0,
                  address_name: e.addressName ?? '',
                  street_address: e.streetAddress ?? '',
                  city_id: e.cityId ?? 0,
                  state: e.state ?? '',
                  zip_code: e.zipCode ?? '',
                  set_as: e.setAs ?? '',
                  city: e.city?.name ?? '',
                ))
            .toList();
        lstAddresses.refresh();
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestPostWishCreation() async {
    isLoading.value = true;
    try {
      var res = await _repository.postCreateWishInfomation(
        productNameController.text,
        '$desiredCountryId',
        productUrlController.text,
        '$wishlistCategoryId',
        strQuantity.value,
        productDescriptionController.text,
        '${addressId.value}',
        trendingWishCategoryId,
        File(imageOne.value?.path ?? ''),
        File(imageTwo.value?.path ?? ''),
        File(imageThree.value?.path ?? ''),
      );

      if (res.statusCode == 200) {
        Get.find<GlobalController>().updateWishesList();
        varifiedTravelersCount = res.data?.userWish?.verified_traveler_counts;
        Get.toNamed(
          Routes().getWishCreationSuccessScreen(),
        );
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestUpdateWish() async {
    isLoading.value = true;
    try {
      var res = await _repository.postUpdateWishInfomation(
        id ?? -1,
        productNameController.text,
        '$desiredCountryId',
        productUrlController.text,
        '$wishlistCategoryId',
        strQuantity.value,
        productDescriptionController.text,
        '${addressId.value}',
        trendingWishCategoryId,
        File(imageOne.value?.path ?? ''),
        File(imageTwo.value?.path ?? ''),
        File(imageThree.value?.path ?? ''),
      );

      if (res.statusCode == 200) {
        Get.find<GlobalController>().updateWishesList();
        varifiedTravelersCount =
            res.data?.userWish?.verified_traveler_counts ?? 0;
        Get.toNamed(
          Routes().getWishCreationSuccessScreen(),
        );
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }
}
