import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iwish_flutter/global_controller/global_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/utils/constants.dart';

import 'package:iwish_flutter/widgets/text_widget.dart';

import '../../../widgets/primary_button.dart';

class PaymentSuccessScreen extends StatelessWidget {
  static const id = '/PaymentSuccessScreen';
  const PaymentSuccessScreen({super.key});

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
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            AppLocalizations.of(context)!.paymentSuccessHeader,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            fontSize: 13.sp,
                            color: ThemeColors().black),
                      ),
                      TextSpan(
                        text:
                            '${Get.arguments != null ? Get.arguments['unit'] : ''} ${Get.arguments != null ? Get.arguments['amount'] : ''}',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                            color: ThemeColors().black),
                      ),
                      TextSpan(
                        text:
                            AppLocalizations.of(context)!.paymentSuccessHeader2,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            fontSize: 13.sp,
                            color: ThemeColors().black),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Image.asset(
                width: 169.w,
                height: 169.h,
                AppAssets.icPaymentSuccess,
              ),
              const Spacer(),
              TextWidget(
                text: AppLocalizations.of(context)!.congrats,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: ThemeColors().black,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: TextWidget(
                  text:
                      '${Get.arguments != null ? Get.arguments['name'] : ''}${AppLocalizations.of(context)!.successfullPaymentMiddleMsg}',
                  textAlign: TextAlign.center,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: ThemeColors().black,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 30.h,
              ),
              PrimaryButton(
                titleText: AppLocalizations.of(context)!.backToWishes,
                onPressed: () {
                  Get.close(2);
                  Get.find<GlobalController>().updateWishesList();
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
