import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/global_controller/global_controller.dart';
import 'package:iwish_flutter/modules/otp/repository/otp_repository.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/widgets/snackbar_popup.dart';

class OtpEmailController extends GetxController {
  RxBool isError = false.obs;
  RxBool isLoading = false.obs;
  final OTPRepository _repository = OTPRepository();
  RxString errorMsg = ''.obs;
  RxString resendTimer = '00:00'.obs;
  late Timer countDownTimer;
  int _secondsRemaining = Constant.OtpRemainingSeconds;
  TextEditingController pinCodeController = TextEditingController();
  bool isLoginFlow = false;
  RxBool isOtpTimeOver = false.obs;
  String email = '';
  bool isTripFlow = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['isTripFlow'] != null) {
        isTripFlow = Get.arguments['isTripFlow'];
        print('isTripFlowOTP-> $isTripFlow');
      }
      email = Get.arguments['email'] ?? '';
    }

    pinCodeController.addListener(() {
      if (pinCodeController.text.length == 4) {
        errorMsg.value = '';
        isError.value = false;
      } else if (pinCodeController.text.isEmpty) {
        errorMsg.value = '';
        isError.value = false;
      }
    });
    startTimer();

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
          await _repository.postVarifyEmail(email, pinCodeController.text);
      if (res.statusCode == 200) {
        isError.value = false;
        errorMsg.value = '';
        await StorageService()
            .writeString(Keys.UserFirstName, res.data?.firstName ?? '');
        await StorageService()
            .writeString(Keys.UserLastName, res.data?.lastName ?? '');
        await StorageService()
            .writeBool(Keys.UserIsVarified, res.data?.isverified ?? false);
        await StorageService().writeBool(
            Keys.UserEmailVarified, res.data?.emailVerified ?? false);
        await StorageService().writeBool(
            Keys.UserPhoneVarified, res.data?.contactnumberVerified ?? false);
        await Get.find<GlobalController>().updateUserData();
        Get.toNamed(Routes().getSuccessScreen());
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
      var res = await _repository.postResendEmailOtp(email);
      pinCodeController.text = '${res.data?.emailverificationcode ?? ''}';
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
