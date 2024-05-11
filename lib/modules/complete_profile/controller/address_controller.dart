import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:iwish_flutter/modules/complete_profile/models/city_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/modules/complete_profile/repository/complete_profile_repository.dart';

class AddressController extends GetxController {
  RxString selectedValue = 'abc'.obs;
  RxBool isLoading = false.obs;
  RxBool isCityLoading = false.obs;
  RxBool noCityDataAvailable = false.obs;

  TextEditingController addressName = TextEditingController();
  TextEditingController streetAddress = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController stateName = TextEditingController();

  FocusNode searchFocusNode = FocusNode();

  Rx<String?> addressNameError = Rx<String?>(null);
  Rx<String?> streetAddressError = Rx<String?>(null);
  Rx<String?> zipCodeError = Rx<String?>(null);
  Rx<String?> stateNameError = Rx<String?>(null);
  Rx<String?> cityNameError = Rx<String?>(null);

  FocusNode focusAddressName = FocusNode();
  FocusNode focusStreetAddress = FocusNode();
  FocusNode focusStateName = FocusNode();
  FocusNode focusZipCode = FocusNode();

  RxString searchHint = "Search city".obs;

  List<String> addressType = ["Primary address", "Secondary address"];
  RxString cityName = AppLocalizations.of(Get.context!)!.enterCityName.obs;
  int city_id = -1;
  int country_id = -1;
  RxString setAs = 'Primary address'.obs;
  var debouncer = Debouncer(delay: const Duration(seconds: 1));

  RxString addressNameHintText =
      AppLocalizations.of(Get.context!)!.enterAddress.obs;
  RxString streetAddressHintText =
      AppLocalizations.of(Get.context!)!.enterStreet.obs;
  RxString zipCodeHintText =
      AppLocalizations.of(Get.context!)!.enterZipCode.obs;
  RxString stateNameHintText =
      AppLocalizations.of(Get.context!)!.enterStateName.obs;

  bool isFromSelectAddress = false;

  RxList<CityViewModel> lstCityData = <CityViewModel>[].obs;

  CompleteProfileRepository repository = CompleteProfileRepository();

  void onFocusTextField() {
    if (focusAddressName.hasFocus) {
      addressNameHintText.value = '';
    } else {
      addressNameHintText.value =
          AppLocalizations.of(Get.context!)!.enterAddress;
    }
    if (focusStreetAddress.hasFocus) {
      streetAddressHintText.value = '';
    } else {
      streetAddressHintText.value =
          AppLocalizations.of(Get.context!)!.enterStreet;
    }
    if (focusStateName.hasFocus) {
      stateNameHintText.value = '';
    } else {
      stateNameHintText.value =
          AppLocalizations.of(Get.context!)!.enterStateName;
    }
    if (focusZipCode.hasFocus) {
      zipCodeHintText.value = '';
    } else {
      zipCodeHintText.value = AppLocalizations.of(Get.context!)!.enterZipCode;
    }
  }

  Future<void> requestPostAddressInformation() async {
    bool isError = false;
    if (addressName.text.isEmpty) {
      addressNameError.value = "Please enter address name";
      isError = true;
    }
    if (streetAddress.text.isEmpty) {
      streetAddressError.value = "Please enter street address";
      isError = true;
    }
    if (zipCode.text.isEmpty) {
      zipCodeError.value = "Please enter zip code";
      isError = true;
    }
    if (stateName.text.isEmpty) {
      stateNameError.value = "Please enter state name";
      isError = true;
    }

    if (city_id == -1) {
      cityNameError.value = "Please select city name";
      isError = true;
    }

    if (isError) {
      return;
    }

    isLoading.value = true;
    try {
      var res = await repository.postAddressInformation(
        addressName.text,
        streetAddress.text,
        city_id,
        stateName.text,
        zipCode.text,
        setAs.value == 'Primary address' ? 'primary' : 'secondary',
        country_id,
      );

      if (res.data != null) {
        if (isFromSelectAddress) {
          Get.back(result: true);
        } else {
          Get.back();
          Get.back();
          Get.back();
          Get.back();
          Get.back();
        }
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestFetchCityData() async {
    if (lstCityData.isNotEmpty) {
      lstCityData.clear();
      lstCityData.refresh();
    }
    isCityLoading.value = true;
    try {
      var res = await repository.getCityData(
        cityNameController.text,
      );
      if (res.isNotEmpty) {
        noCityDataAvailable.value = false;
        lstCityData.addAll(res);
        lstCityData.refresh();
      } else {
        noCityDataAvailable.value = true;
      }
    } catch (e) {
      e.printError();
      rethrow;
    } finally {
      isCityLoading.value = false;
    }
  }

  @override
  void onInit() async {
    if (Get.arguments != null && Get.arguments['isAddAddress'] != null) {
      isFromSelectAddress = Get.arguments['isAddAddress'] ?? false;
    }
    await requestFetchCityData();
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        searchHint.value = '';
      } else {
        searchHint.value = 'Search city';
      }
    });

    cityNameController.addListener(() {
      if (cityNameController.text.length < 3) return;
      debouncer.call(() {
        requestFetchCityData();
      });
    });

    addressName.addListener(() {
      if (addressName.text.isNotEmpty) addressNameError.value = null;
    });

    streetAddress.addListener(() {
      if (streetAddress.text.isNotEmpty) streetAddressError.value = null;
    });

    stateName.addListener(() {
      if (stateName.text.isNotEmpty) stateNameError.value = null;
    });

    zipCode.addListener(() {
      if (zipCode.text.isNotEmpty) zipCodeError.value = null;
    });

    focusAddressName.addListener(onFocusTextField);
    focusStateName.addListener(onFocusTextField);
    focusStreetAddress.addListener(onFocusTextField);
    focusZipCode.addListener(onFocusTextField);
    super.onInit();
  }
}
