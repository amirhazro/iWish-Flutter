import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iwish_flutter/modules/trending_wishes/controller/trending_wishes_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/back_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';
import 'package:twemoji/twemoji.dart';

class SearchFilter extends StatelessWidget {
  final TrendingWishesController controller;
  final VoidCallback onApply;
  final VoidCallback onCancel;

  const SearchFilter({
    super.key,
    required this.controller,
    required this.onApply,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.searchFocusNode.hasFocus) {
          Utils.dismissKeyboard(context);
        } else {
          Utils.dismissKeyboard(context);
          controller.searchCountryController.text = '';
          controller.isDesiredCountryDropDownVisible.value = false;
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: ThemeColors().white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.sp),
                topRight: Radius.circular(12.sp))),
        padding: EdgeInsets.all(24.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                TextWidget(
                  text: AppLocalizations.of(context)!.filter,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: ThemeColors().black,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TopBarBackButton(
                    iconPath: AppAssets.icBackCross,
                    width: 30.sp,
                    height: 30.sp,
                    iconWidth: 11.w,
                    iconHeight: 11.h,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            TextWidget(
              text: AppLocalizations.of(context)!.filterByCountry,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ThemeColors().homeTopCardTextColor,
            ),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
              onTap: () {
                controller.isDesiredCountryDropDownVisible.value =
                    !controller.isDesiredCountryDropDownVisible.value;
                controller.searchCountryController.text = '';
                Utils.dismissKeyboard(Get.context!);
              },
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ThemeColors().greyBorder,
                  ),
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => TextWidget(
                        text: controller.strCountry.value,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors().homeTopCardTextColor,
                      ),
                    ),
                    Image.asset(
                      AppAssets.icArrowDownBlack,
                      width: 16.w,
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ),
            countryDropDownArea(),
            SizedBox(
              height: 8.h,
            ),
            TextWidget(
              text: AppLocalizations.of(context)!.filterByCategory,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ThemeColors().homeTopCardTextColor,
            ),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
              onTap: () {
                controller.isCategoryDropDownVisible.value =
                    !controller.isCategoryDropDownVisible.value;
              },
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ThemeColors().greyBorder,
                  ),
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Obx(
                        () => TextWidget(
                          text: controller.strCategory.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: ThemeColors().homeTopCardTextColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Image.asset(
                      AppAssets.icArrowDownBlack,
                      width: 16.w,
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            categoryDropDownAres(),
            SizedBox(
              height: 24.h,
            ),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    titleText: 'Clear Filter',
                    onPressed: onCancel,
                    backgroundColor: Colors.transparent,
                    foregroundColor: ThemeColors().black,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    buttonRadius: 10.sp,
                    width: Get.width,
                    height: 50.h,
                    borderSide: BorderSide(
                      color: ThemeColors().secondaryColorOne,
                      width: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: PrimaryButton(
                    titleText: AppLocalizations.of(context)!.applyFilter,
                    onPressed: onApply,
                    backgroundColor: ThemeColors().primaryColorOne,
                    foregroundColor: ThemeColors().black,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    buttonRadius: 10.sp,
                    width: Get.width,
                    height: 50.h,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget countryDropDownArea() {
    return Obx(
      () => AnimatedContainer(
        margin: EdgeInsets.only(left: 0.w, right: 0.w, bottom: 12.h, top: 10.h),
        duration: const Duration(
          milliseconds: 500,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        constraints: BoxConstraints(
          maxHeight:
              controller.isDesiredCountryDropDownVisible.value ? 300.h : 0.h,
        ),
        decoration: BoxDecoration(
          color: ThemeColors().white,
          border: Border.all(
            color: controller.isDesiredCountryDropDownVisible.value
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

  Widget categoryDropDownAres() {
    return Obx(
      () => AnimatedContainer(
        margin: EdgeInsets.only(
          bottom: 12.h,
        ),
        duration: const Duration(
          milliseconds: 500,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ),
        constraints: BoxConstraints(
            maxHeight:
                controller.isCategoryDropDownVisible.value ? 200.h : 0.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: controller.isCategoryDropDownVisible.value
                ? ThemeColors().greyBorder
                : ThemeColors().greyBorder.withOpacity(0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: ListView.builder(
          itemCount: controller.lstInterestData.length,
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () => controller.handleCategorySelection(index),
              child: Container(
                width: Get.width,
                color: ThemeColors().transparent,
                height: 25.h,
                margin: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  children: [
                    Obx(
                      () => controller.lstInterestData[index].isSelected.value
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
                    TextWidget(
                      text: controller.lstInterestData[index].title ?? "",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ThemeColors().greyDropDownValue,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
