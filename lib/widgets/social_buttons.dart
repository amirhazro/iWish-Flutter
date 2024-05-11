import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';

class SocialLoginButtons extends StatelessWidget {
  final EdgeInsets margin;
  final VoidCallback loginWithGoogle;
  final VoidCallback loginWithFacebook;
  final VoidCallback loginWithApple;

  const SocialLoginButtons({
    super.key,
    required this.margin,
    required this.loginWithGoogle,
    required this.loginWithFacebook,
    required this.loginWithApple,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: loginWithGoogle,
              child: Container(
                decoration: getSocialBoxDecoration(),
                padding:
                    EdgeInsets.symmetric(horizontal: 14.sp, vertical: 14.sp),
                child: Image.asset(
                  AppAssets.icGoogleLogo,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
          ),
          if (Platform.isIOS)
            SizedBox(
              width: 20.w,
            ),
          if (Platform.isIOS)
            Expanded(
              child: GestureDetector(
                onTap: loginWithApple,
                child: Container(
                  decoration: getSocialBoxDecoration(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.sp, vertical: 14.sp),
                  child: Image.asset(
                    AppAssets.icAppleLogo,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              ),
            ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: GestureDetector(
              onTap: loginWithFacebook,
              child: Container(
                decoration: getSocialBoxDecoration(),
                padding:
                    EdgeInsets.symmetric(horizontal: 14.sp, vertical: 14.sp),
                child: Image.asset(
                  AppAssets.icFacebookLogo,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration getSocialBoxDecoration() {
    return BoxDecoration(
      color: ThemeColors().greySocialButtons,
      borderRadius: BorderRadius.circular(
        Constant.buttonRadius.sp,
      ),
    );
  }
}
