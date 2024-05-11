import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/splash/controller/splash_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class SplashScreen extends StatelessWidget {
  static const id = "/SplashScreen";
  SplashScreen({super.key});
  final SplashController splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.splashBackground,
            width: Get.width,
            height: Get.height,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: 200.h,
            left: 50.w,
            right: 50.w,
            child: Obx(
              () => AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: splashController.isAppear.value ? 1 : 0,
                child: Image.asset(
                  AppAssets.icLogo,
                  width: 93.w,
                  height: 108.h,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(
              () => AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: splashController.isAppear.value ? 1 : 0,
                child: Container(
                  padding: EdgeInsets.only(bottom: 24.sp),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget(
                        text: AppLocalizations.of(context)!.splashText1,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30.sp,
                      ),
                      TextWidget(
                          text: AppLocalizations.of(context)!.splashText2,
                          textAlign: TextAlign.center,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30.sp),
                      SizedBox(
                        height: 4.h,
                      ),
                      TextWidget(
                        text: AppLocalizations.of(context)!.splashText3,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrimaryButton(
                            titleText: AppLocalizations.of(context)!.login,
                            onPressed: () {
                              Get.toNamed(
                                Routes().getSignInPage(),
                                arguments: {
                                  'login': true,
                                },
                              );
                            },
                            width: 140.w,
                            height: 48.h,
                            backgroundColor: ThemeColors().primaryColor,
                            foregroundColor: ThemeColors().white,
                            textSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            buttonRadius: Constant.buttonRadius.sp,
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          PrimaryButton(
                            titleText: AppLocalizations.of(context)!.signup,
                            onPressed: () {
                              Get.toNamed(
                                Routes().getSignInPage(),
                                arguments: {
                                  'login': false,
                                },
                              );
                            },
                            width: 120.w,
                            height: 48.h,
                            backgroundColor: Colors.transparent,
                            foregroundColor: ThemeColors().white,
                            textSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            buttonRadius: Constant.buttonRadius.sp,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
