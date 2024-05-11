import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';

class TopBarBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? iconPath;
  final double? width;
  final double? height;
  final double? iconWidth;
  final double? iconHeight;
  const TopBarBackButton({
    super.key,
    required this.onPressed,
    this.iconPath,
    this.height,
    this.width,
    this.iconWidth,
    this.iconHeight,
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
            color: ThemeColors().white,
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
          width: iconWidth ?? 6.w,
          height: iconHeight ?? 12.h,
        ),
      ),
    );
  }
}
