import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class InterestLoadingScreen extends StatefulWidget {
  static const id = "/InterestLoadingScreen";
  const InterestLoadingScreen({super.key});

  @override
  State<InterestLoadingScreen> createState() => _InterestLoadingScreenState();
}

class _InterestLoadingScreenState extends State<InterestLoadingScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes().getBottomNavigationScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(false);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.w),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextWidget(
                    text: AppLocalizations.of(context)!.loading,
                    color: ThemeColors().black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),
              ),
              const Spacer(),
              Image.asset(
                AppAssets.icWait,
                width: 230.w,
                height: 358.h,
              ),
              const Spacer(),
              TextWidget(
                text: AppLocalizations.of(context)!.pleaseWait,
                color: ThemeColors().black,
                fontWeight: FontWeight.w300,
                fontSize: 15.sp,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
