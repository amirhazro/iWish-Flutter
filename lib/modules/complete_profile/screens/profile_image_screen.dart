import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/widgets/back_button.dart';

import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import '../../../widgets/primary_button.dart';
import '../controller/complete_account_controller.dart';

// ignore: must_be_immutable
class ProfileImageScreen extends StatelessWidget {
  static const id = '/ProfileImageScreen';
  ProfileImageScreen({super.key});
  var controller = Get.find<CompleteAccountController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Expanded(
                  child: Stack(children: [
                    Positioned(
                      top: 55.h,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TopBarBackButton(
                            onPressed: () {
                              Get.back();
                            },
                            width: 35.w,
                            height: 35.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (controller.isTripFlow) {
                                Get.close(4);
                              } else {
                                Get.toNamed(Routes().getAddressScreen());
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 16.w,
                                  right: 16.w,
                                  top: 10.h,
                                  bottom: 10.h),
                              decoration: BoxDecoration(
                                  color: ThemeColors().greySocialButtons,
                                  borderRadius: BorderRadius.circular(24.sp)),
                              child: TextWidget(
                                text: AppLocalizations.of(context)!.skip,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                color: ThemeColors().homeTopCardTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.icVarifiedProfilePic,
                          width: 41.w,
                          height: 48.h,
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        TextWidget(
                          text: AppLocalizations.of(context)!
                              .profilePictureDetail,
                          textAlign: TextAlign.center,
                          fontSize: 12.6.sp,
                          fontWeight: FontWeight.w400,
                          color: ThemeColors().homeTopCardTextColor,
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Obx(
                          () => controller.imageOne.value != null
                              ? showImage(context, controller.imageOne.value!,
                                  () {
                                  controller.showImagePickerDialog(context);
                                })
                              : imagePlaceHolder(
                                  () =>
                                      controller.showImagePickerDialog(context),
                                  context,
                                  controller.isProfilePicError.value),
                        ),
                      ],
                    ),
                  ]),
                ),
                PrimaryButton(
                  titleText: AppLocalizations.of(context)!.finalize,
                  onPressed: () => controller.requestPostProfileImage(context),
                  backgroundColor: ThemeColors().primaryColorOne,
                  foregroundColor: ThemeColors().black,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  buttonRadius: Constant.buttonRadius.sp,
                  width: Get.width,
                  height: 50.h,
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePlaceHolder(
      VoidCallback onTap, BuildContext context, bool isError) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: DottedBorder(
            dashPattern: const [12, 6],
            color: isError ? ThemeColors().errorRed : ThemeColors().greyBorder,
            borderType: BorderType.RRect,
            radius: Radius.circular(10.sp),
            child: Container(
              height: 223.h,
              width: 223.w,
              decoration: const BoxDecoration(),
              padding: EdgeInsets.all(12.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    isError
                        ? AppAssets.icProfilePicError
                        : AppAssets.icProfilePic,
                    width: 70.w,
                    height: 80.h,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  TextWidget(
                    text: AppLocalizations.of(context)!.profilePicture,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        isError ? ThemeColors().errorRed : ThemeColors().black,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextWidget(
                    text: "jpg or png",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color:
                        isError ? ThemeColors().errorRed : ThemeColors().black,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        if (isError)
          TextWidget(
            text: "File is too large, maximum file\nsize is 6 mb",
            textAlign: TextAlign.center,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: ThemeColors().errorRed,
          ),
      ],
    );
  }

  Widget showImage(context, XFile file, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(file.path),
          width: 223.w,
          height: 223.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
