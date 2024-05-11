import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwish_flutter/modules/create_a_wish/controller/product_detail_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:iwish_flutter/widgets/error_text.dart';
import 'package:iwish_flutter/widgets/input_field.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';
import 'package:twemoji/twemoji.dart';

import '../../../widgets/primary_button.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String id = '/ProductDetailScreen';
  final controller = Get.find<ProductDetailController>();
  ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: GestureDetector(
          onTap: () {
            if (controller.searchFocusNode.hasFocus) {
              Utils.dismissKeyboard(context);
            } else {
              Utils.dismissKeyboard(context);
              controller.searchCountryController.text = '';
              controller.isDesiredCountryDropDownVisible.value = false;
            }
          },
          child: Scaffold(
            backgroundColor: ThemeColors().white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: CustomSecondaryAppBar(
                title: AppLocalizations.of(context)!.productDetails,
                onBackPressed: () {
                  Get.back();
                },
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    _selectImageWidget(context),
                    SizedBox(
                      height: 16.h,
                    ),
                    Obx(
                      () => CustomInputField(
                        isMandatory: true,
                        textEditingController: controller.productNameController,
                        focusNode: controller.productNameFocusNode,
                        hintText: controller.productNameHintText.value,
                        fieldTitle: AppLocalizations.of(context)!.productName,
                        isPasswordField: false,
                        textInputType: TextInputType.text,
                        errorMsg: controller.errorMsgProductName.value,
                        isEnable: controller.isProductNameEnable.value,
                        inputFormatData: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r"[a-zA-Z0-9\-()_\'\‘\’ ]")),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        TextWidget(
                          text: AppLocalizations.of(context)!
                              .desiredCountryOfPurchase,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors().homeTopCardTextColor,
                        ),
                        TextWidget(
                          text: ' *',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors().errorRed,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.isCountryEnable.value) {
                          controller.isDesiredCountryDropDownVisible.value =
                              !controller.isDesiredCountryDropDownVisible.value;
                          controller.searchCountryController.text = '';
                          Utils.dismissKeyboard(context);
                        }
                      },
                      child: Container(
                        width: Get.width,
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
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
                                text: controller.strDesiredCountry.value,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: controller.isCountryEnable.value
                                    ? ThemeColors().black
                                    : ThemeColors().grey.withOpacity(0.7),
                              ),
                            ),
                            Opacity(
                              opacity:
                                  controller.isCountryEnable.value ? 1 : 0.7,
                              child: Image.asset(
                                AppAssets.icArrowDownBlack,
                                width: 16.w,
                                height: 16.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => ErrorText(
                        text: controller.errorMsgCountry.value,
                        maintainState: false,
                      ),
                    ),
                    countryDropDownArea(),
                    CustomInputField(
                      focusNode: controller.productUrlFocusNode,
                      hintText: controller.productUrlHintText.value,
                      textEditingController: controller.productUrlController,
                      fieldTitle: AppLocalizations.of(context)!.productUrl,
                      isPasswordField: false,
                      textInputType: TextInputType.text,
                      isEnable: controller.isUrlEnable.value,
                      inputFormatData: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z0-9\-()_:.\'\‘\’/\\\ ]")),
                      ],
                    ),
                    Row(
                      children: [
                        TextWidget(
                          text: AppLocalizations.of(context)!.category,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors().homeTopCardTextColor,
                        ),
                        TextWidget(
                          text: ' *',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors().errorRed,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.isCategoryEnable.value) {
                          controller.isDesiredCategoryDropDownVisible.value =
                              !controller
                                  .isDesiredCategoryDropDownVisible.value;
                        }
                      },
                      child: Container(
                        width: Get.width,
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
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
                                text: controller.strCategory.value,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: controller.isCategoryEnable.value
                                    ? ThemeColors().black
                                    : ThemeColors().grey.withOpacity(0.7),
                              ),
                            ),
                            Opacity(
                              opacity:
                                  controller.isCategoryEnable.value ? 1 : 0.7,
                              child: Image.asset(
                                AppAssets.icArrowDownBlack,
                                width: 16.w,
                                height: 16.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Obx(() => ErrorText(
                          text: controller.errorMsgCategory.value,
                        )),
                    categoryDropDownArea(),
                    Row(
                      children: [
                        TextWidget(
                          text: AppLocalizations.of(context)!.quantity,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors().homeTopCardTextColor,
                        ),
                        TextWidget(
                          text: ' *',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors().errorRed,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ThemeColors().greyBorder,
                        ),
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      child: Obx(
                        () => IgnorePointer(
                          ignoring: !controller.isQuantityEnabled.value,
                          child: Opacity(
                            opacity:
                                controller.isQuantityEnabled.value ? 1 : 0.5,
                            child: quantityWidget(
                              context,
                              controller.strQuantity.value,
                              controller.quantityIncrease,
                              controller.quantityDecrease,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomInputField(
                      textEditingController:
                          controller.productDescriptionController,
                      focusNode: controller.productDescriptionFocusNode,
                      hintText: controller.productDescHintText.value,
                      fieldTitle:
                          AppLocalizations.of(context)!.productDescription,
                      isPasswordField: false,
                      textInputType: TextInputType.text,
                      maxLines: 10,
                      minLines: 6,
                      isEnable: controller.isDescriptionEnable.value,
                      inputFormatData: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z0-9\-()_.,\'\‘\’ ]")),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Obx(
                      () => IgnorePointer(
                        ignoring: controller.isImagesLoading.value,
                        child: Opacity(
                          opacity: controller.isImagesLoading.value ? 0.5 : 1,
                          child: PrimaryButton(
                            titleText: AppLocalizations.of(context)!.proceed,
                            onPressed: controller.moveToOrderSummaryScreen,
                            backgroundColor:
                                ThemeColors().toggleSwitchBackgroundColorActive,
                            foregroundColor: ThemeColors().black,
                            textSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            buttonRadius: 10.sp,
                            width: Get.width,
                            height: 50.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectImageWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IgnorePointer(
          ignoring: (!controller.isImageChangeEnable.value &&
              controller.imageOne.value != null),
          child: Opacity(
            opacity: (!controller.isImageChangeEnable.value &&
                    controller.imageOne.value != null)
                ? 0.5
                : 1,
            child: Obx(
              () => controller.imageOne.value != null
                  ? showImage(context, controller.imageOne.value!, () {
                      controller.showImagePickerDialog(context, 1);
                    })
                  : imagePlaceHolder(context, () {
                      controller.showImagePickerDialog(context, 1);
                    }, controller.isFirstImageLoading.value),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: (!controller.isImageChangeEnable.value &&
              controller.imageTwo.value != null),
          child: Opacity(
            opacity: (!controller.isImageChangeEnable.value &&
                    controller.imageTwo.value != null)
                ? 0.5
                : 1,
            child: Obx(
              () => controller.imageTwo.value != null
                  ? showImage(context, controller.imageTwo.value!, () {
                      controller.showImagePickerDialog(context, 2);
                    })
                  : imagePlaceHolder(context, () {
                      controller.showImagePickerDialog(context, 2);
                    }, controller.isSecondImageLoading.value),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: (!controller.isImageChangeEnable.value &&
              controller.imageThree.value != null),
          child: Opacity(
            opacity: (!controller.isImageChangeEnable.value &&
                    controller.imageThree.value != null)
                ? 0.5
                : 1,
            child: Obx(
              () => controller.imageThree.value != null
                  ? showImage(context, controller.imageThree.value!, () {
                      controller.showImagePickerDialog(context, 3);
                    })
                  : imagePlaceHolder(context, () {
                      controller.showImagePickerDialog(context, 3);
                    }, controller.isThirdImageLoading.value),
            ),
          ),
        )
      ],
    );
  }

  Widget imagePlaceHolder(
      BuildContext context, VoidCallback onTap, bool isLoading) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        color: ThemeColors().greyBorder,
        borderType: BorderType.RRect,
        radius: Radius.circular(10.sp),
        child: Container(
          height: 105.h,
          width: 101.w,
          alignment: Alignment.center,
          decoration: const BoxDecoration(),
          padding: EdgeInsets.all(12.sp),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeColors().primaryColorOne,
                    strokeWidth: 1,
                  ),
                )
              : Column(
                  children: [
                    Image.asset(
                      AppAssets.icSelectImagePlaceholder,
                      width: 23.w,
                      height: 24.h,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TextWidget(
                      text: AppLocalizations.of(context)!.upload,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: ThemeColors().black,
                    ),
                    TextWidget(
                      text: "jpg or png",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors().black,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget showImage(context, XFile file, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(file.path),
          width: 101.w,
          height: 101.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget quantityWidget(BuildContext context, String value,
      VoidCallback onIcrement, VoidCallback onDecrement) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onDecrement,
          child: Container(
            padding: EdgeInsets.all(4.sp),
            color: Colors.transparent,
            child: Image.asset(
              AppAssets.icQuantityMinus,
              width: 12.w,
              height: 12.h,
            ),
          ),
        ),
        TextWidget(
          text: value,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: ThemeColors().homeTopCardTextColor,
        ),
        GestureDetector(
          onTap: onIcrement,
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(4.sp),
            child: Image.asset(
              AppAssets.icQuantityPlus,
              width: 12.w,
              height: 12.h,
            ),
          ),
        ),
      ],
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

  Widget categoryDropDownArea() {
    return Obx(
      () => AnimatedContainer(
        margin: EdgeInsets.only(
          bottom: 8.h,
        ),
        duration: const Duration(
          milliseconds: 500,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ),
        constraints: BoxConstraints(
          maxHeight:
              controller.isDesiredCategoryDropDownVisible.value ? 300.h : 0.h,
        ),
        decoration: BoxDecoration(
          border: Border.all(
              color: controller.isDesiredCategoryDropDownVisible.value
                  ? ThemeColors().greyBorder
                  : ThemeColors().greyBorder.withOpacity(0),
              width: 1),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: ListView.builder(
          itemCount: controller.lstInterestData.length,
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () => controller.handleCategorySelection(index),
              child: Container(
                margin: EdgeInsets.only(bottom: 4.h, top: 4.h),
                child: Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        text: Get.locale?.languageCode == "en"
                            ? controller.lstInterestData[index].title ?? ""
                            : controller.lstInterestData[index].titleAr ?? "",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
    );
  }
}
