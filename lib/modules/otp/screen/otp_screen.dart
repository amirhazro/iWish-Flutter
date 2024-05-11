import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/otp/controller/otp_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/back_button.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatelessWidget {
  static const id = "/OTPScreen";

  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.find<OtpController>();
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: GestureDetector(
          onTap: () => Utils.dismissKeyboard(context),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Image.asset(
                  AppAssets.icBgSigninSignup,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: Get.height * 0.2,
                        ),
                        Image.asset(
                          AppAssets.icIwishLogo,
                          width: 137.w,
                          height: 131.h,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 55.h,
                        ),
                        TextWidget(
                          text: AppLocalizations.of(context)!.otpTitle,
                          textAlign: TextAlign.center,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        TextWidget(
                          text: AppLocalizations.of(context)!
                              .otpMiddleInformation,
                          textAlign: TextAlign.center,
                          color: ThemeColors().grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),
                        SizedBox(
                          height: 34.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constant.generalMargin),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                () => PinCodeTextField(
                                  appContext: context,
                                  length: 4,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  controller: controller.pinCodeController,
                                  animationType: AnimationType.scale,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(10.sp),
                                    fieldHeight: 76.h,
                                    fieldWidth: 53.w,
                                    fieldOuterPadding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    selectedColor: !controller.isError.value
                                        ? ThemeColors().greyBorder
                                        : ThemeColors().errorRed,
                                    activeColor: !controller.isError.value
                                        ? ThemeColors().greyBorder
                                        : Colors.red,
                                    inactiveColor: !controller.isError.value
                                        ? ThemeColors().greyBorder
                                        : Colors.red,
                                    activeFillColor: ThemeColors().white,
                                    selectedFillColor: ThemeColors().white,
                                  ),
                                  onChanged: (value) {},
                                  cursorColor: ThemeColors().black,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  errorTextSpace: 0.0,
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Obx(
                                () => TextWidget(
                                  text: controller.errorMsg.value,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ThemeColors().errorRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: AppLocalizations.of(context)!.otpExpiresIn,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors().greyLight,
                            ),
                            Obx(
                              () => TextWidget(
                                text: controller.resendTimer.value,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: ThemeColors().blackLightColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        Obx(
                          () => IgnorePointer(
                            ignoring: !controller.isOtpTimeOver.value,
                            child: Opacity(
                              opacity: controller.isOtpTimeOver.value ? 1 : 0.5,
                              child: GestureDetector(
                                onTap: controller.requestResendOtpInformation,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: ThemeColors().greyUnderline,
                                        width: 1.sp,
                                      ),
                                    ),
                                  ),
                                  child: TextWidget(
                                    text:
                                        AppLocalizations.of(context)!.otpResend,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColors().blackLightColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Constant.generalMargin),
                          child: PrimaryButton(
                            titleText: AppLocalizations.of(context)!.verifyOtp,
                            onPressed: controller.requestSubmitOtpInformation,
                            backgroundColor: ThemeColors().primaryColorOne,
                            foregroundColor: ThemeColors().black,
                            textSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            buttonRadius: Constant.buttonRadius.sp,
                            width: Get.width,
                            height: 50.h,
                          ),
                        ),
                        SizedBox(
                          height: 56.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: Get.width * 0.03,
                  top: Get.height * 0.1,
                  child: TopBarBackButton(
                    width: 32.sp,
                    height: 32.sp,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
