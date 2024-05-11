import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class VerificationScreen extends StatelessWidget {
  static const id = '/VerificationScreen';
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors().white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomSecondaryAppBar(
          title: AppLocalizations.of(context)!.verification,
          onBackPressed: () {
            Get.back();
          },
          isBackButtonRequired: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            verificationWidget(
              context,
              () {
                Get.toNamed(Routes().getCameraView());
              },
              AppAssets.icCard,
              AppLocalizations.of(context)!.uploadDocuments,
              AppLocalizations.of(context)!.nationalIdVerification,
              AppLocalizations.of(context)!.nationalIdVerificationDetail,
            ),
            verificationWidget(
                context,
                () {},
                AppAssets.icBank,
                AppLocalizations.of(context)!.uploadDocuments,
                AppLocalizations.of(context)!.bankVerification,
                AppLocalizations.of(context)!.bankVerificationDetail),
            verificationWidget(
              context,
              () {},
              AppAssets.icPlaceHolderSmall,
              AppLocalizations.of(context)!.addYourAddress,
              AppLocalizations.of(context)!.address,
              AppLocalizations.of(context)!.addressDetail,
            )
          ],
        ),
      ),
    );
  }

  Widget verificationWidget(
    BuildContext context,
    VoidCallback onTap,
    String icon,
    String buttonName,
    String title,
    String detail,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
      decoration: BoxDecoration(
          color: ThemeColors().culturedTwo,
          borderRadius: BorderRadius.circular(12.sp)),
      width: Get.width,
      child: Column(
        children: [
          Image.asset(
            icon,
            width: 50.w,
            height: 50.h,
          ),
          SizedBox(
            height: 12.h,
          ),
          TextWidget(
            text: title,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: ThemeColors().black,
          ),
          SizedBox(
            height: 8.h,
          ),
          TextWidget(
            text: detail,
            fontWeight: FontWeight.w300,
            fontSize: 12.sp,
            color: ThemeColors().black,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16.h,
          ),
          PrimaryButton(
            titleText: buttonName,
            onPressed: onTap,
            backgroundColor: ThemeColors().primaryColorOne,
            foregroundColor: ThemeColors().black,
            textSize: 11.sp,
            fontWeight: FontWeight.w600,
            buttonRadius: 8.sp,
            width: 202.w,
            height: 34.h,
          )
        ],
      ),
    );
  }
}
