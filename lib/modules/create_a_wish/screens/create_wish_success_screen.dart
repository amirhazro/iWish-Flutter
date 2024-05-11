import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/create_a_wish/controller/product_detail_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/utils/constants.dart';

import 'package:iwish_flutter/widgets/text_widget.dart';

import '../../../widgets/primary_button.dart';

class CreateWishSuccessScreen extends StatelessWidget {
  static const id = '/CreateWishSuccessScreen';
  const CreateWishSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(false);
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color: ThemeColors().greyBorder,
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                child: Column(
                  children: [
                    TextWidget(
                      text:
                          '${Get.find<ProductDetailController>().varifiedTravelersCount} ${AppLocalizations.of(context)!.numberTraverlers}',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors().black,
                    ),
                    TextWidget(
                      text: AppLocalizations.of(context)!.varifiedTravelers,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors().black,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Image.asset(
                width: Get.width,
                AppAssets.icWishCreationSuccess,
              ),
              const Spacer(),
              TextWidget(
                text: AppLocalizations.of(context)!.thankyou,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: ThemeColors().black,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: TextWidget(
                  text: Get.find<ProductDetailController>().isEditFlow
                      ? AppLocalizations.of(context)!.wishUpdateSuccessfully
                      : !Get.find<ProductDetailController>().isAllEditable
                          ? AppLocalizations.of(context)!.wishPlaceSuccessfully
                          : AppLocalizations.of(context)!.wishPlaceSuccessfully,
                  textAlign: TextAlign.center,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: ThemeColors().black,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ThemeColors().greyUnderline,
                      width: 1.sp,
                    ),
                  ),
                ),
                child: TextWidget(
                  text: AppLocalizations.of(context)!.checkDeliveryOffers,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: ThemeColors().black,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              PrimaryButton(
                titleText: Get.find<ProductDetailController>().isEditFlow ||
                        !Get.find<ProductDetailController>().isAllEditable
                    ? AppLocalizations.of(context)!.back
                    : AppLocalizations.of(context)!.backToHome,
                onPressed: () {
                  Get.close(4);
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
            ],
          ),
        ),
      ),
    );
  }
}
