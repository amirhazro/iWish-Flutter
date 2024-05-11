import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/global_controller/spoken_langugae_controller.dart';
import 'package:iwish_flutter/models/spoken_language_modal.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

// ignore: must_be_immutable
class LanguageSelection extends StatelessWidget {
  late SpokenLanguageController controller;

  LanguageSelection(List<SpokenLanguageModal> lstData, {super.key}) {
    controller = Get.put(SpokenLanguageController());
    controller.lstLanguageData.value = lstData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: AppLocalizations.of(context)!.spokenLanguage,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: ThemeColors().homeTopCardTextColor,
        ),
        SizedBox(
          height: 8.sp,
        ),
        GestureDetector(
          onTap: controller.showHideDropDown,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeColors().greyBorder,
              ),
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => TextWidget(
                      text: controller.selectedLanguage.value.isEmpty
                          ? AppLocalizations.of(context)!.selectLanguage
                          : controller.selectedLanguage.value,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: controller.selectedLanguage.value.isEmpty
                          ? ThemeColors().greyAddress
                          : ThemeColors().homeTopCardTextColor,
                    ),
                  ),
                ),
                Image.asset(
                  AppAssets.icArrowDown,
                  width: 12.w,
                  height: 12.h,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Obx(
          () => AnimatedContainer(
            margin: EdgeInsets.only(bottom: 12.h),
            duration: const Duration(
              milliseconds: 500,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            constraints: BoxConstraints(
                maxHeight: controller.isVisible.value ? 350.h : 0.h),
            decoration: BoxDecoration(
              border: Border.all(
                  color: controller.isVisible.value
                      ? ThemeColors().greyBorder
                      : ThemeColors().greyBorder.withOpacity(0),
                  width: 1),
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: ListView.builder(
              itemCount: controller.lstLanguageData.length,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () => controller.handleSelection(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: [
                        Obx(
                          () =>
                              controller.lstLanguageData[index].isSelected.value
                                  ? Image.asset(
                                      AppAssets.icChkbxSelected,
                                      width: 16.w,
                                      height: 16.h,
                                    )
                                  : Image.asset(
                                      AppAssets.icChkbxUnSelected,
                                      width: 16.w,
                                      height: 16.h,
                                    ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: TextWidget(
                            text: controller
                                    .lstLanguageData[index].langugaeName ??
                                '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: ThemeColors().greyDropDownValue,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
