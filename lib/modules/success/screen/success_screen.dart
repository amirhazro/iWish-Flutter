import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class SuccessScreen extends StatefulWidget {
  static const id = '/SuccessScreen';
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(false);
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(24.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Image.asset(
                AppAssets.icOtpSuccess,
                width: 410.w,
                height: 410.h,
              ),
              TextWidget(
                text: AppLocalizations.of(context)!.successfully,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: ThemeColors().black,
              ),
              SizedBox(
                height: 8.h,
              ),
              TextWidget(
                text: AppLocalizations.of(context)!.successEmail,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: ThemeColors().grey,
              ),
              const Spacer(),
              PrimaryButton(
                titleText: AppLocalizations.of(context)!.continuee,
                onPressed: () {
                  Get.toNamed(Routes().getProfileImageScreen());
                },
                backgroundColor:
                    ThemeColors().toggleSwitchBackgroundColorActive,
                foregroundColor: ThemeColors().black,
                textSize: 14.sp,
                fontWeight: FontWeight.w500,
                buttonRadius: 10.sp,
                width: Get.width,
                height: 50.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
