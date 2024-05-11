import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';

class TopBarTransparentBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? iconPath;
  final double? width;
  final double? height;
  const TopBarTransparentBackButton({
    super.key,
    required this.onPressed,
    this.iconPath,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.all(
          8.sp,
        ),
        decoration: BoxDecoration(
            color: ThemeColors().transparent,
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(
              color: ThemeColors().greyBorder,
              width: 1,
            )),
        child: Image.asset(
          iconPath == null
              ? Get.locale!.languageCode == 'en'
                  ? AppAssets.icBackArrow
                  : AppAssets.icBackArrowAr
              : iconPath!,
          width: 6.w,
          height: 12.h,
          color: ThemeColors().white,
        ),
      ),
    );
  }
}
