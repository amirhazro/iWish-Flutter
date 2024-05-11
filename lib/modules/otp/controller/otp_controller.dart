import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/otp/repository/otp_repository.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/widgets/snackbar_popup.dart';

import '../../../utils/routes.dart';

class OtpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  final OTPRepository _repository = OTPRepository();
  RxString errorMsg = ''.obs;
  RxString resendTimer = '00:00'.obs;
  late Timer countDownTimer;
  int _secondsRemaining = Constant.OtpRemainingSeconds;
  TextEditingController pinCodeController = TextEditingController();
  bool isLoginFlow = false;
  RxBool isOtpTimeOver = false.obs;
  String phoneNumber = '';

  @override
  void onInit() {
    isLoginFlow = Get.arguments['isLoginFlow'] ?? false;
    phoneNumber = Get.arguments['phoneNumber'] ?? '';
    startTimer();

    pinCodeController.addListener(() {
      if (pinCodeController.text.length == 4) {
        errorMsg.value = '';
        isError.value = false;
      } else if (pinCodeController.text.isEmpty) {
        errorMsg.value = '';
        isError.value = false;
      }
    });

    super.onInit();
  }

  void requestSubmitOtpInformation() async {
    if (pinCodeController.text.isEmpty || pinCodeController.text.length < 4) {
      isError.value = true;
      errorMsg.value = "Please enter 4 digit code.";
      return;
    } else {
      isError.value = false;
      errorMsg.value = "";
    }
    isLoading.value = true;
    try {
      var res =
          await _repository.postVerifyOtp(phoneNumber, pinCodeController.text);

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
      await StorageService().writeBool(Keys.UserPhoneVarified,
          res.data?.user?.contactnumberVerified ?? false);
      await StorageService()
          .writeInt(Keys.UserInterest, res.data?.has_interest ?? 0);

      if (res.statusCode == 200) {
        isError.value = false;
        errorMsg.value = "";
        if (res.data?.has_interest == 1) {
          Get.offAllNamed(Routes().getBottomNavigationScreen());
        } else {
          Get.offAllNamed(Routes().getInterestScreen());
        }
      }
    } catch (e) {
      isError.value = true;
      errorMsg.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void requestResendOtpInformation() async {
    isLoading.value = true;
    try {
      var res = await _repository.postResendOtp(phoneNumber);

      pinCodeController.text = '${res.data?.numberverificationcode ?? ' '}';
      isOtpTimeOver.value = false;
      startTimer();
    } catch (e) {
      SnackbarPopup.show(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void startTimer() {
    countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        int minutes = _secondsRemaining ~/ 60;
        int seconds = _secondsRemaining % 60;
        resendTimer.value =
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      } else {
        isOtpTimeOver.value = true;
        _secondsRemaining = Constant.OtpRemainingSeconds;
        timer.cancel();
      }
    });
  }
}
