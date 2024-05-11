import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iwish_flutter/modules/signin/controller/signin_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/social_buttons.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';
import 'package:twemoji/twemoji.dart';

class SignInScreen extends StatelessWidget {
  static const id = "/SignInScreen";

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.find<SignInController>();
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => controller.dismissKeyboardAndHideDropDown(context),
            child: Stack(
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
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            Obx(
                              () => TextWidget(
                                text: controller.isLoginFlow.value
                                    ? AppLocalizations.of(context)!.welcomeback
                                    : AppLocalizations.of(context)!
                                        .createYourAccount,
                                textAlign: TextAlign.center,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            TextWidget(
                              text: controller.isLoginFlow.value
                                  ? AppLocalizations.of(context)!
                                      .entermobilenumber
                                  : AppLocalizations.of(context)!
                                      .entermobilenumberRgistration,
                              textAlign: TextAlign.center,
                              color: ThemeColors().grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp,
                            ),
                            SizedBox(
                              height: 34.h,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: Constant.generalMargin,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ThemeColors().white,
                                      borderRadius: BorderRadius.circular(8.sp),
                                      border: Border.all(
                                        color: controller.isError.value
                                            ? ThemeColors().errorRed
                                            : ThemeColors().greyBorder,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: controller.handleCountryPicker,
                                          child: Container(
                                            margin: EdgeInsets.all(2.sp),
                                            color: ThemeColors().white,
                                            padding: EdgeInsets.all(
                                                Constant.generalPadding),
                                            child: Row(
                                              children: [
                                                Obx(
                                                  () => Twemoji(
                                                    emoji: controller
                                                        .flagPath.value,
                                                    width: 25.w,
                                                    height: 25.h,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12.w,
                                                ),
                                                Obx(
                                                  () => TextWidget(
                                                    text: controller
                                                        .selectedCountry.value,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: controller
                                                            .isError.value
                                                        ? ThemeColors().errorRed
                                                        : ThemeColors().black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12.w,
                                                ),
                                                Image.asset(
                                                  AppAssets.icArrowDown,
                                                  width: 12.w,
                                                  height: 12.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: controller
                                                .phoneNumberController,
                                            onTap: () {
                                              controller
                                                  .isCountryDropDownVisible
                                                  .value = false;
                                            },
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                              isDense: true,
                                            ),
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                signed: false, decimal: false),
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: controller.isError.value
                                                  ? ThemeColors().errorRed
                                                  : ThemeColors().black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                            inputFormatters: [
                                              RemoveEmojiInputFormatter(),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              controller.inputFormatter
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.isError.value,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: Constant.generalMargin,
                                        right: Constant.generalMargin,
                                        top: 10.h,
                                      ),
                                      child: Obx(
                                        () => TextWidget(
                                          text: controller.errorMsg.value,
                                          color: ThemeColors().errorRed,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            countryDropDownArea(controller),
                            SizedBox(
                              height: 16.h,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Constant.generalMargin),
                              child: Obx(
                                () => PrimaryButton(
                                  titleText: controller.isLoginFlow.value
                                      ? AppLocalizations.of(context)!.login
                                      : AppLocalizations.of(context)!.signUp,
                                  onPressed: () => controller
                                      .requestSubmitLoginInformation(context),
                                  backgroundColor:
                                      ThemeColors().primaryColorOne,
                                  foregroundColor: ThemeColors().black,
                                  textSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  buttonRadius: Constant.buttonRadius.sp,
                                  width: Get.width,
                                  height: 50.h,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 26.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 68.w,
                                  height: 0.5,
                                  color: ThemeColors().greyDivider,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                TextWidget(
                                  text: AppLocalizations.of(context)!
                                      .orContinueWith,
                                  color: ThemeColors().black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  width: 68.w,
                                  height: 0.5,
                                  color: ThemeColors().greyDivider,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 26.h,
                            ),
                            SocialLoginButtons(
                              margin: EdgeInsets.only(
                                left: Constant.generalMargin,
                                right: Constant.generalMargin,
                              ),
                              loginWithGoogle:
                                  controller.signInSignUpWithGoogle,
                              loginWithFacebook:
                                  controller.signInSignUpWithFacebook,
                              loginWithApple: controller.signInWithApple,
                            ),
                            SizedBox(
                              height: 26.h,
                            ),
                            GestureDetector(
                              onTap: controller.handlerJoinNowNavigation,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => TextWidget(
                                      text: controller.isLoginFlow.value
                                          ? AppLocalizations.of(context)!
                                              .notMemeber
                                          : AppLocalizations.of(context)!
                                              .aMember,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300,
                                      color: ThemeColors().black,
                                    ),
                                  ),
                                  Obx(
                                    () => TextWidget(
                                      text: controller.isLoginFlow.value
                                          ? AppLocalizations.of(context)!
                                              .joinNow
                                          : AppLocalizations.of(context)!
                                              .loginNow,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300,
                                      color: ThemeColors().primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                          ],
                        ),
                        Positioned(
                          right: Get.width * 0.03,
                          top: Get.height * 0.1,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Obx(
                              () => FlutterSwitch(
                                width: 65.w,
                                height: 35.h,
                                valueFontSize: 12.sp,
                                toggleSize: 25.sp,
                                value: controller.isArabicLanguage.value,
                                inactiveColor: ThemeColors()
                                    .toggleSwitchBackgroundColorActive,
                                activeColor: ThemeColors()
                                    .toggleSwitchBackgroundColorInactive,
                                borderRadius: 14.sp,
                                padding: 3.sp,
                                activeText: 'AR',
                                activeTextColor: ThemeColors().white,
                                inactiveTextColor: ThemeColors().black,
                                switchBorder: Border.all(
                                  color: ThemeColors().toggleSwitchBorderColor,
                                ),
                                inactiveToggleColor:
                                    ThemeColors().toggleSwitchThumbColorActive,
                                activeToggleColor: ThemeColors()
                                    .toggleSwitchThumbColorInActive,
                                inactiveText: 'EN',
                                showOnOff: true,
                                onToggle: controller.handleLangugaeToggle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget countryDropDownArea(SignInController controller) {
    return Obx(
      () => AnimatedContainer(
        margin:
            EdgeInsets.only(left: 24.w, right: 24.w, bottom: 12.h, top: 10.h),
        duration: const Duration(
          milliseconds: 500,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        constraints: BoxConstraints(
          maxHeight: controller.isCountryDropDownVisible.value ? 300.h : 0.h,
        ),
        decoration: BoxDecoration(
          color: ThemeColors().white,
          border: Border.all(
            color: controller.isCountryDropDownVisible.value
                ? ThemeColors().greyBorder
                : ThemeColors().greyBorder.withOpacity(0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 2.h),
                decoration: BoxDecoration(
                  color: ThemeColors().greySocialButtons,
                  border: Border.all(
                    color: ThemeColors().greySocialButtons,
                  ),
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppAssets.icSearch,
                      height: 23.h,
                      width: 23.w,
                      color: ThemeColors().silverChalice,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: controller.searchFocusNode,
                        textAlign: TextAlign.start,
                        controller: controller.searchCountryController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(
                          color: ThemeColors().homeTopCardTextColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: controller.searchCountryHint.value,
                          isDense: true,
                          hintStyle: GoogleFonts.poppins(
                            color: ThemeColors().greyAddress,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        autofocus: false,
                        inputFormatters: [
                          RemoveEmojiInputFormatter(),
                          FilteringTextInputFormatter.allow(
                              RegExp(r"[a-zA-Z0-9\-()_\'\‘\’ ]")),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 8.h),
                itemCount: controller.lstCountriesData.length,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () => controller.handleCountrySelection(index),
                    child: Container(
                      color: ThemeColors().transparent,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          Twemoji(
                            emoji:
                                controller.lstCountriesData[index].flagPath ??
                                    '',
                            height: 25.h,
                            width: 25.w,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          TextWidget(
                            text: controller
                                    .lstCountriesData[index].countryName ??
                                "",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: ThemeColors().greyDropDownValue,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlagClipper extends CustomClipper<Path> {
  const _FlagClipper(this.radius);

  final double radius;

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);

    path.addOval(Rect.fromCircle(center: center, radius: radius));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
