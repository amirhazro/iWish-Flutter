import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/back_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class NewWishBottomSheetContent extends StatelessWidget {
  final VoidCallback onCreateNewWishPressed;
  final VoidCallback onTrendingWishesPressed;
  final VoidCallback onInfoIconTapIstButton;
  final VoidCallback onInfoIconTap2ndButton;
  const NewWishBottomSheetContent({
    super.key,
    required this.onCreateNewWishPressed,
    required this.onTrendingWishesPressed,
    required this.onInfoIconTapIstButton,
    required this.onInfoIconTap2ndButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              TextWidget(
                text: AppLocalizations.of(context)!.newWish,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: ThemeColors().black,
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TopBarBackButton(
                  iconPath: AppAssets.icBackCross,
                  width: 30.sp,
                  height: 30.sp,
                  iconWidth: 11.w,
                  iconHeight: 11.h,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
          TextWidget(
            text: AppLocalizations.of(context)!.selectOneWish,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: ThemeColors().grey,
          ),
          SizedBox(
            height: 12.h,
          ),
          GestureDetector(
            onTap: onCreateNewWishPressed,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12.sp,
                vertical: 8.sp,
              ),
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: ThemeColors().greySocialButtons,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppAssets.icStar,
                    width: 26.w,
                    height: 26.h,
                  ),
                  TextWidget(
                    text: AppLocalizations.of(context)!.createAWish,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors().homeTopCardTextColor,
                  ),
                  GestureDetector(
                    onTap: onInfoIconTapIstButton,
                    child: Image.asset(
                      AppAssets.icInfoIcon,
                      width: 26.w,
                      height: 26.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: onTrendingWishesPressed,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12.sp,
                vertical: 8.sp,
              ),
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: ThemeColors().greySocialButtons,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppAssets.icFlame,
                    width: 26.w,
                    height: 26.h,
                  ),
                  TextWidget(
                    text: AppLocalizations.of(context)!.trendingWishes,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors().homeTopCardTextColor,
                  ),
                  GestureDetector(
                    onTap: onInfoIconTap2ndButton,
                    child: Image.asset(
                      AppAssets.icInfoIcon,
                      width: 26.w,
                      height: 26.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
