import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/create_a_wish/controller/product_detail_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/custom_secondary_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/primary_button.dart';

class ProductSummaryScreen extends StatelessWidget {
  static const id = "/ProductSummaryScreen";
  final controller = Get.find<ProductDetailController>();
  ProductSummaryScreen({super.key});

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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(controller.imageOne.value?.path ?? ''),
                          width: 225.w,
                          height: 225.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(controller.imageTwo.value?.path ?? ''),
                              width: 107.w,
                              height: 107.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(controller.imageThree.value?.path ?? ''),
                              width: 107.w,
                              height: 107.h,
                              fit: BoxFit.cover,
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
                  PrimaryButton(
                    titleText: controller.isEditFlow
                        ? AppLocalizations.of(context)!.updateWish
                        : !controller.isAllEditable
                            ? AppLocalizations.of(context)!.reWish
                            : AppLocalizations.of(context)!.createWish,
                    onPressed: () {
                      if (controller.isEditFlow) {
                        controller.requestUpdateWish();
                      } else {
                        controller.requestPostWishCreation();
                      }
                    },
                    backgroundColor: ThemeColors().primaryColorOne,
                    foregroundColor: ThemeColors().black,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    buttonRadius: Constant.buttonRadius.sp,
                    width: Get.width,
                    height: 50.h,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextWidget(
                    text: AppLocalizations.of(context)!.wishTermsAndCondition,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                    color: ThemeColors().homeTopCardTextColor,
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
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
              child: GestureDetector(
                onTap: () async {
                  if (desc.isNotEmpty) {
                    Uri? uri = Uri.tryParse(controller.formatURL(desc));

                    if (uri != null &&
                        !await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        )) {
                      throw 'Could not launch $uri';
                    }
                  }
                },
                child: Image.asset(
                  AppAssets.icUrl,
                  width: 25.w,
                  height: 25.h,
                ),
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
