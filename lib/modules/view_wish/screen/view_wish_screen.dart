import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/view_wish/controller/view_wish_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

import '../../../widgets/custom_secondary_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewWishScreen extends StatelessWidget {
  static const id = "/ViewWishScreen";
  final controller = Get.find<ViewWishController>();
  ViewWishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          backgroundColor: ThemeColors().white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: CustomSecondaryAppBar(
              title: AppLocalizations.of(context)!.productSummary,
              onBackPressed: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => controller.imageOne.value != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(controller.imageOne.value?.path ?? ''),
                                  width: 225.w,
                                  height: 225.h,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : imagePlaceHolder(
                                context,
                                () {},
                                225.w,
                                225.h,
                                controller.isFirstImageLoading.value,
                              ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => controller.imageTwo.value != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(controller.imageTwo.value?.path ??
                                          ''),
                                      width: 107.w,
                                      height: 107.h,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : imagePlaceHolder(
                                    context,
                                    () {},
                                    107.w,
                                    107.h,
                                    controller.isSecondImageLoading.value,
                                  ),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Obx(
                            () => controller.imageThree.value != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(controller.imageThree.value?.path ??
                                          ''),
                                      width: 107.w,
                                      height: 107.h,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : imagePlaceHolder(
                                    context,
                                    () {},
                                    107.w,
                                    107.h,
                                    controller.isSecondImageLoading.value,
                                  ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  TextWidget(
                    text: AppLocalizations.of(context)!.productDetails,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ThemeColors().homeTopCardTextColor,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  productDetailContainer(
                    context,
                    AppLocalizations.of(context)!.productName,
                    controller.productNameController.text,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: productDetailContainer(
                          context,
                          AppLocalizations.of(context)!.quantity,
                          int.parse(controller.strQuantity.value) > 1
                              ? '${controller.strQuantity.value} Pieces'
                              : '${controller.strQuantity.value} Piece',
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Expanded(
                        child: productDetailContainer(
                            context,
                            AppLocalizations.of(context)!.productUrl,
                            controller.productUrlController.text,
                            isUrl: true,
                            width: Get.width * 0.9),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  productDetailContainer(
                    context,
                    AppLocalizations.of(context)!.productDescription,
                    controller.productDescriptionController.text,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  productDetailContainer(
                    context,
                    AppLocalizations.of(context)!.desiredCountryOfPurchase,
                    controller.strDesiredCountry.value,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePlaceHolder(BuildContext context, VoidCallback onTap,
      double width, double height, bool isLoading) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        color: ThemeColors().greyBorder,
        borderType: BorderType.RRect,
        radius: Radius.circular(10.sp),
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(),
          padding: EdgeInsets.all(12.sp),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeColors().primaryColorOne,
                    strokeWidth: 1,
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }

  Widget productDetailContainer(BuildContext context, String title, String desc,
      {bool isUrl = false, double? width}) {
    if (isUrl) {
      return Container(
        width: width,
        decoration: BoxDecoration(
          color: ThemeColors().greySocialButtons,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        padding: EdgeInsets.all(12.sp),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: title,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors().homeTopCardTextColor,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  TextWidget(
                    text: desc,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors().homeTopCardTextColor,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(
                AppAssets.icUrl,
                width: 25.w,
                height: 25.h,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: ThemeColors().greySocialButtons,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: ThemeColors().homeTopCardTextColor,
            ),
            SizedBox(
              height: 4.h,
            ),
            TextWidget(
              text: desc,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ThemeColors().homeTopCardTextColor,
            )
          ],
        ),
      );
    }
  }
}
