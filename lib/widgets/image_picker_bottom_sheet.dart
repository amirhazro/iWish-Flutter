import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/back_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final VoidCallback onPickFromGallary;
  final VoidCallback onPickFromCamera;
  const ImagePickerBottomSheet({
    super.key,
    required this.onPickFromGallary,
    required this.onPickFromCamera,
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
                text: AppLocalizations.of(context)!.imagePicker,
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
            text: AppLocalizations.of(context)!.imagePickerDetail,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: ThemeColors().grey,
          ),
          SizedBox(
            height: 12.h,
          ),
          GestureDetector(
            onTap: onPickFromCamera,
            child: Container(
              width: Get.width,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                horizontal: 12.sp,
                vertical: 8.sp,
              ),
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: ThemeColors().greySocialButtons,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: TextWidget(
                text: AppLocalizations.of(context)!.pickFromCamer,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: ThemeColors().homeTopCardTextColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: onPickFromGallary,
            child: Container(
              alignment: Alignment.center,
              width: Get.width,
              margin: EdgeInsets.symmetric(
                horizontal: 12.sp,
                vertical: 8.sp,
              ),
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: ThemeColors().greySocialButtons,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: TextWidget(
                text: AppLocalizations.of(context)!.pickFromGallary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: ThemeColors().homeTopCardTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
