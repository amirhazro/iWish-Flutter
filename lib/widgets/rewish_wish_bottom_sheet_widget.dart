import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/back_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/image_widget.dart';
import 'package:iwish_flutter/widgets/picture_widget.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:twemoji/twemoji.dart';

class ReWishBottomSheetContent extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String pictureName;
  final String countryName;
  final String countryFlag;
  final String productName;
  final String userName;
  final String userImage;
  const ReWishBottomSheetContent({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    required this.pictureName,
    required this.countryName,
    required this.countryFlag,
    required this.productName,
    required this.userName,
    required this.userImage,
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
                text: AppLocalizations.of(context)!.confirmation,
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
          SizedBox(
            height: 16.h,
          ),
          TextWidget(
            text: AppLocalizations.of(context)!.confirmationMsg,
            textAlign: TextAlign.center,
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
            color: ThemeColors().grey,
          ),
          SizedBox(
            height: 32.h,
          ),
          Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: ThemeColors().greySocialButtons,
              borderRadius: BorderRadius.circular(
                10.sp,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PictureNetworkWidget(
                  imageUrl: userImage,
                  width: 23.w,
                  height: 23.w,
                  borderRadius: 4.sp,
                ),
                SizedBox(width: 10.w),
                TextWidget(
                  text: userName,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w300,
                  color: ThemeColors().black,
                )
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          ImageWidget(
            imagePath: pictureName,
            borderRadius: 10.sp,
            width: 141.w,
            height: 131.w,
            placeHolderImage: AppAssets.icPlaceHolderSmall,
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextWidget(
              text: productName,
              maxLines: 1,
              textAlign: TextAlign.center,
              fontSize: 15.sp,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w500,
              color: ThemeColors().black,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Twemoji(
                emoji: countryFlag.isNotEmpty ? countryFlag : '🌍',
                width: 25.w,
                height: 25.h,
              ),
              SizedBox(
                width: 10.h,
              ),
              TextWidget(
                text: _getCountryName(countryName),
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
                color: ThemeColors().homeTopCardTextColor,
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  titleText: AppLocalizations.of(context)!.cancel,
                  onPressed: onCancel,
                  backgroundColor: Colors.transparent,
                  foregroundColor: ThemeColors().black,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  buttonRadius: 10.sp,
                  width: Get.width,
                  height: 50.h,
                  borderSide: BorderSide(
                    color: ThemeColors().secondaryColorOne,
                    width: 1,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: PrimaryButton(
                  titleText: AppLocalizations.of(context)!.confirm,
                  onPressed: onConfirm,
                  backgroundColor: ThemeColors().primaryColorOne,
                  foregroundColor: ThemeColors().black,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  buttonRadius: 10.sp,
                  width: Get.width,
                  height: 50.h,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _getCountryName(String countryName) {
    if (countryName.toLowerCase() == 'any') return "Anywhere";
    return countryName;
  }
}
