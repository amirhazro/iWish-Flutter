import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RatingDoneBottomSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  final String title;
  final String detail;

  const RatingDoneBottomSheet({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 40.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppAssets.icRatingStar,
            width: 109.w,
            height: 104.h,
          ),
          SizedBox(
            height: 40.h,
          ),
          TextWidget(
            text: title,
            color: ThemeColors().black,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
          SizedBox(
            height: 16.h,
          ),
          TextWidget(
            text: detail,
            color: ThemeColors().black,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 32.h,
          ),
          PrimaryButton(
            titleText: AppLocalizations.of(context)!.done,
            onPressed: onConfirm,
            backgroundColor: ThemeColors().primaryColorOne,
            foregroundColor: ThemeColors().black,
            textSize: 14.sp,
            fontWeight: FontWeight.w500,
            buttonRadius: 8.sp,
            width: Get.width,
            height: 50.h,
            borderSide: BorderSide(
              color: ThemeColors().secondaryColorOne,
              width: 1,
            ),
          ),
        ],
      ),
    );
  }
}
