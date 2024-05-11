import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:iwish_flutter/global_controller/social_controller.dart';
import 'package:iwish_flutter/modules/otp/models/otp_response_model.dart';
import 'package:iwish_flutter/modules/signin/repository/signin_signup_repository.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/snackbar_popup.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../services/storage_service.dart';
import '../../../utils/keys.dart';
import '../../../utils/routes.dart';
import '../models/countries_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInController extends GetxController {
  final MaskTextInputFormatter inputFormatter = MaskTextInputFormatter(
      mask: '#### #### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  RxBool isLoading = false.obs;
  RxBool isArabicLanguage = false.obs;
  RxBool isError = false.obs;
  RxString errorMsg = ''.obs;
  String countryCode = '';
  RxString selectedCountry = ''.obs;
  TextEditingController searchCountryController = TextEditingController();
  RxString searchCountryHint =
      AppLocalizations.of(Get.context!)!.searchByName.obs;
  RxString flagPath = ''.obs;
  RxBool isCountryDropDownVisible = false.obs;
  final SignInSignUpRepository _repository = SignInSignUpRepository();
  TextEditingController phoneNumberController = TextEditingController();
  RxBool isLoginFlow = false.obs;
  RxList<CountryViewModel> lstCountriesData = <CountryViewModel>[].obs;
  List<CountryViewModel> lstCountriesRawData = <CountryViewModel>[];
  FocusNode searchFocusNode = FocusNode();
  Debouncer debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void onInit() async {
    isLoginFlow.value = Get.arguments['login'] ?? false;
    if (Get.locale?.languageCode == 'en') {
      isArabicLanguage.value = false;
    } else {
      isArabicLanguage.value = true;
    }

    await requestGetCountriesList();
    phoneNumberController.addListener(() {
      String phoneNo = '${selectedCountry.value}${phoneNumberController.text}';
      if (Utils.isValidPhoneNumber(
          phoneNo.replaceAll(' ', '').replaceAll('-', ''))) {
        isError.value = false;
        errorMsg.value = '';
      }
    });

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

  void handleLangugaeToggle(bool val) {
    isArabicLanguage.value = val;
    if (isArabicLanguage.value) {
      _setLocale(const Locale('ar'));
    } else {
      _setLocale(const Locale('en'));
    }
  }

  void _setLocale(Locale locale) async {
    await StorageService().writeString(Keys.locale, locale.languageCode);
    Get.updateLocale(locale);
  }

  void requestSubmitLoginInformation(BuildContext context) async {
    dismissKeyboardAndHideDropDown(context);
    if (phoneNumberController.text.isEmpty) {
      isError.value = true;
      errorMsg.value = 'Please enter a number.';
      return;
    } else {
      String phoneNo = '${selectedCountry.value}${phoneNumberController.text}';
      if (Utils.isValidPhoneNumber(
          phoneNo.replaceAll(' ', '').replaceAll('-', ''))) {
        isError.value = false;
        errorMsg.value = '';
      } else {
        isError.value = true;
        errorMsg.value = 'Mobile number is Incorrect';
        return;
      }
    }

    String phoneNo = ('${selectedCountry.value}${phoneNumberController.text}')
        .replaceAll(" ", "")
        .replaceAll('-', '');
    isLoading.value = true;
    try {
      await _repository.postUserPhoneNumberForLoginOrSignup(
          phoneNo, isLoginFlow.value ? EndPoints.login : EndPoints.createUser);

      Get.toNamed(Routes().getOtpPage(), arguments: {
        "isLoginFlow": isLoginFlow.value,
        'phoneNumber': phoneNo,
      });
    } catch (e) {
      SnackbarPopup.show(e.toString(), isError: true, title: "Error");
    } finally {
      isLoading.value = false;
    }
  }

  void handlerJoinNowNavigation() {
    isLoginFlow.value = !isLoginFlow.value;
  }

  void handleCountryPicker() {
    isCountryDropDownVisible.value = !isCountryDropDownVisible.value;
    Utils.dismissKeyboard(Get.context!);
  }

  void handleCountrySelection(int index) {
    selectedCountry.value = lstCountriesData[index].dialCode ?? '';
    flagPath.value = lstCountriesData[index].flagPath ?? '';
    isCountryDropDownVisible.value = !isCountryDropDownVisible.value;
    searchCountryController.text = '';
    dismissKeyboardAndHideDropDown(Get.context!);
  }

  void dismissKeyboardAndHideDropDown(BuildContext context) {
    if (searchFocusNode.hasFocus) {
      Utils.dismissKeyboard(context);
    } else {
      Utils.dismissKeyboard(context);
      isCountryDropDownVisible.value = false;
    }
  }

  //API Region

  Future<void> requestGetCountriesList() async {
    isLoading.value = true;
    try {
      var res = await _repository.getCountriesList(
          type: 'login', searchCountryController.text);

      if (res.isNotEmpty) {
        if (lstCountriesData.isNotEmpty) {
          lstCountriesData.clear();
        }

        lstCountriesData.addAll(res);
        lstCountriesRawData.addAll(res);
        lstCountriesData.refresh();
        selectedCountry.value = lstCountriesData.first.dialCode ?? '';
        flagPath.value = lstCountriesData.first.flagPath ?? '';
      }
    } catch (e) {
      SnackbarPopup.show(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //Socials Login
  void signInSignUpWithGoogle() async {
    try {
      var cntrlr = Get.find<SocialsController>();
      var resultSSN = await cntrlr.signInWithGoogle();

      //Calling API to verify SSN Login/Signup.
      final Map<String, String> data = {
        'token': resultSSN.idToken ?? '',
        'platform': Platform.isAndroid ? 'android' : 'ios'
      };
      final body = jsonEncode(data);
      var res = await _repository.socialSignInVarification(
        EndPoints.signUpWithGoogle,
        body,
      );

      onSuccessSocialLoginResponse(res);
    } catch (e) {
      print('exception->${e.toString()}');
    }
  }

  void signInSignUpWithFacebook() async {
    try {
      var cntrlr = Get.find<SocialsController>();
      var result = await cntrlr.loginWithFacebook();

      //Calling API to verify SSN Login/Signup.
      if (result.status == LoginStatus.success) {
        final Map<String, String> data = {
          'accessToken': result.accessToken?.token ?? '',
        };
        final body = jsonEncode(data);

        var res = await _repository.socialSignInVarification(
            EndPoints.signUpWithFaceBook, body);
        onSuccessSocialLoginResponse(res);
      }
    } catch (e) {
      print('exception->${e.toString()}');
    }
  }

  void signInWithApple() async {
    try {
      var cntrlr = Get.find<SocialsController>();
      var result = await cntrlr.loginWithApple();

      //Calling API to verify SSN Login/Signup.
      final Map<String, String> data = {
        'identityToken': result.identityToken ?? '',
        'identifier': result.userIdentifier ?? ''
      };
      final body = jsonEncode(data);

      var res = await _repository.socialSignInVarification(
          EndPoints.signUpWithApple, body);
      onSuccessSocialLoginResponse(res);
    } catch (e) {
      print('exception->${e.toString()}');
    }
  }

  onSuccessSocialLoginResponse(VerifiedOtpResponseModel res) async {
    await StorageService()
        .writeString(Keys.Auth_Token, res.data?.authtoken ?? '');
    await StorageService().writeInt(Keys.UserId, res.data?.user?.id ?? -1);
    await StorageService()
        .writeString(Keys.UserFirstName, res.data?.user?.firstName ?? '');
    await StorageService()
        .writeString(Keys.UserLastName, res.data?.user?.lastName ?? '');
    await StorageService()
        .writeString(Keys.UserPicture, res.data?.user?.picture ?? '');
    await StorageService()
        .writeBool(Keys.UserIsVarified, res.data?.user?.isverified ?? false);
    await StorageService().writeBool(
        Keys.UserEmailVarified, res.data?.user?.emailVerified ?? false);
    await StorageService().writeBool(
        Keys.UserPhoneVarified, res.data?.user?.contactnumberVerified ?? false);
    await StorageService()
        .writeInt(Keys.UserInterest, res.data?.has_interest ?? 0);

    if (res.statusCode == 200) {
      if (res.data?.has_interest == 1) {
        Get.offAllNamed(Routes().getBottomNavigationScreen());
      } else {
        Get.offAllNamed(Routes().getInterestScreen());
      }
    }
  }
}
