import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/back_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class TripAddedConfirmation extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCrossPressed;
  final String? titleText;
  final String? descriptionText;
  final String? boxText;
  final String? buttonText;
  final String? icon;
  final Color? buttonBackgroundColor;

  const TripAddedConfirmation({
    super.key,
    required this.onConfirm,
    required this.onCrossPressed,
    this.titleText,
    this.descriptionText,
    this.boxText,
    this.buttonText,
    this.icon,
    this.buttonBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TopBarBackButton(
                  iconPath: AppAssets.icBackCross,
                  width: 33.sp,
                  height: 33.sp,
                  iconWidth: 11.w,
                  iconHeight: 11.h,
                  onPressed: onCrossPressed,
                ),
              ),
            ],
          ),
          Image.asset(
            icon ?? AppAssets.icShieldBig,
            width: 65.w,
            height: 75.h,
          ),
          SizedBox(
            height: 32.h,
          ),
          TextWidget(
            text: titleText ?? AppLocalizations.of(context)!.youreVarified,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: ThemeColors().black,
          ),
          SizedBox(
            height: 12.h,
          ),
          TextWidget(
            text: descriptionText ??
                AppLocalizations.of(context)!.varifiedAddedWish,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
            color: ThemeColors().grey,
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 8.sp,
            ),
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: ThemeColors().greyBorder,
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: TextWidget(
              text: boxText ??
                  AppLocalizations.of(context)!.varifiedAddedWishBoxDetail,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: ThemeColors().black,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          PrimaryButton(
            titleText: buttonText ??
                AppLocalizations.of(context)!.checkedMatchedWishes,
            onPressed: onConfirm,
            backgroundColor:
                buttonBackgroundColor ?? ThemeColors().primaryColorOne,
            foregroundColor: buttonBackgroundColor != null
                ? ThemeColors().white
                : ThemeColors().black,
            textSize: 14.sp,
            fontWeight: FontWeight.w500,
            buttonRadius: 8.sp,
            width: Get.width,
            height: 50.h,
          ),
        ],
      ),
    );
  }
}
