import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/back_button.dart';
import 'package:iwish_flutter/widgets/back_button_transparent.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class CustomSecondaryAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;
  final VoidCallback? onFilterPressed;
  final VoidCallback? onDeletePressed;
  final VoidCallback? onBlockPressed;
  final VoidCallback? onReportPressed;
  final bool isFilterButton;
  final bool isBackButtonRequired;
  final bool isDeleteWishButtonRequired;
  final bool isTransparentButton;
  final bool isChatScreen;
  const CustomSecondaryAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
    this.onFilterPressed,
    this.onDeletePressed,
    this.isFilterButton = false,
    this.isBackButtonRequired = true,
    this.isDeleteWishButtonRequired = false,
    this.isTransparentButton = false,
    this.isChatScreen = false,
    this.onBlockPressed,
    this.onReportPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      margin: EdgeInsets.only(top: 40.h, left: 16.w, right: 16.w),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          if (isBackButtonRequired)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: isTransparentButton
                  ? TopBarTransparentBackButton(
                      onPressed: onBackPressed,
                      width: 32.sp,
                      height: 32.sp,
                    )
                  : TopBarBackButton(
                      onPressed: onBackPressed,
                      width: 32.sp,
                      height: 32.sp,
                    ),
            ),
          TextWidget(
            text: title,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color:
                isTransparentButton ? ThemeColors().white : ThemeColors().black,
          ),
          if (isFilterButton)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: GestureDetector(
                onTap: onFilterPressed,
                child: Image.asset(
                  AppAssets.icFilters,
                  width: 28.w,
                  height: 28.h,
                ),
              ),
            ),
          if (isDeleteWishButtonRequired)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: GestureDetector(
                onTap: onDeletePressed,
                child: Image.asset(
                  AppAssets.icDeleteWish,
                  width: 35.w,
                  height: 35.h,
                ),
              ),
            ),
          if (isChatScreen)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: onBlockPressed,
                    child: Image.asset(
                      AppAssets.icBlockBg,
                      width: 35.w,
                      height: 35.h,
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  GestureDetector(
                    onTap: onReportPressed,
                    child: Image.asset(
                      AppAssets.icReportBg,
                      width: 35.w,
                      height: 35.h,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
