import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iwish_flutter/modules/complete_profile/controller/complete_account_controller.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/input_field.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

import '../../../widgets/custom_secondary_app_bar.dart';
import '../../../widgets/language_selection.dart';

// ignore: must_be_immutable
class CompleteAccountScreen extends StatelessWidget {
  static const id = "/CompleteAccountScreen";

  CompleteAccountScreen({super.key});

  var controller = Get.find<CompleteAccountController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.h),
            child: CustomSecondaryAppBar(
              title: '',
              onBackPressed: () {
                Get.back();
              },
            ),
          ),
          body: GestureDetector(
            onTap: () {
              controller.onFocusTextField();
              Utils.dismissKeyboard(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.w,
                vertical: 16.h,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: AppLocalizations.of(context)!
                                .completeYourAccount,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: ThemeColors().black,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextWidget(
                            text: AppLocalizations.of(context)!
                                .completeYourAccountDetail,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: ThemeColors().grey,
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          CustomInputField(
                            isMandatory: true,
                            textEditingController: controller.emailController,
                            fieldTitle: AppLocalizations.of(context)!.email,
                            hintText: controller.emailHintText.value,
                            isPasswordField: false,
                            autoFocus: true,
                            textInputType: TextInputType.emailAddress,
                            focusNode: controller.focusEmail,
                            errorMsg: controller.emailError.value,
                            inputFormatData: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z0-9\-()_:.@\'\‘\’/\\\ ]")),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomInputField(
                                  isMandatory: true,
                                  textEditingController:
                                      controller.firstNameController,
                                  fieldTitle:
                                      AppLocalizations.of(context)!.firstName,
                                  hintText: controller.fnameHintText.value,
                                  isPasswordField: false,
                                  textInputType: TextInputType.name,
                                  focusNode: controller.focusFname,
                                  errorMsg: controller.fnameError.value,
                                  inputFormatData: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r"[a-zA-Z0-9\-()_\'\‘\’ ]")),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Expanded(
                                child: CustomInputField(
                                  isMandatory: true,
                                  textEditingController:
                                      controller.lastNameController,
                                  fieldTitle:
                                      AppLocalizations.of(context)!.lastName,
                                  hintText: controller.lnameHintText.value,
                                  isPasswordField: false,
                                  textInputType: TextInputType.name,
                                  focusNode: controller.focusLname,
                                  errorMsg: controller.lnameError.value,
                                  inputFormatData: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r"[a-zA-Z0-9\-()_\'\‘\’ ]")),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Obx(
                            () => LanguageSelection(
                              // ignore: invalid_use_of_protected_member
                              controller.lstLangugaeData.value,
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          // TextWidget(
                          // text: AppLocalizations.of(context)!
                          //     .termsAndPoliciesText,
                          //   fontSize: 12.6.sp,
                          //   fontWeight: FontWeight.w400,
                          //   color: ThemeColors().homeTopCardTextColor,
                          // ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.6.sp,
                                    color: ThemeColors().homeTopCardTextColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  text: AppLocalizations.of(context)!
                                      .termsAndPoliciesText,
                                ),
                                TextSpan(
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.6.sp,
                                      color: ThemeColors().homeTopCardTextColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    text: AppLocalizations.of(context)!
                                        .termsOfService,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(Routes()
                                            .getTermsAndConditionScreen());
                                      }),
                                TextSpan(
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.6.sp,
                                      color: ThemeColors().homeTopCardTextColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    text: AppLocalizations.of(context)!.and),
                                TextSpan(
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.6.sp,
                                      color: ThemeColors().homeTopCardTextColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    text: AppLocalizations.of(context)!
                                        .privacyPolicy,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(
                                            Routes().getPrivacyPolicyScreen());
                                      }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          PrimaryButton(
                              titleText: AppLocalizations.of(context)!.next,
                              onPressed:
                                  controller.requestPostProfileInformation,
                              backgroundColor: ThemeColors()
                                  .toggleSwitchBackgroundColorActive,
                              foregroundColor: ThemeColors().black,
                              textSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              buttonRadius: 10.sp,
                              width: Get.width,
                              height: 50.h)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
