import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteWishBottomSheet extends StatelessWidget {
  final VoidCallback onCancelPressed;
  final VoidCallback onYesPleasePressed;
  const DeleteWishBottomSheet(
      {super.key,
      required this.onCancelPressed,
      required this.onYesPleasePressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            text: AppLocalizations.of(context)!.deleteWish,
            color: ThemeColors().black,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
          SizedBox(
            height: 16.h,
          ),
          TextWidget(
            text: AppLocalizations.of(context)!.deleteWishMsg,
            color: ThemeColors().grey,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 24.h,
          ),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  titleText: AppLocalizations.of(context)!.cancel,
                  onPressed: onCancelPressed,
                  backgroundColor: ThemeColors().transparent,
                  foregroundColor: ThemeColors().black,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  buttonRadius: 8.sp,
                  width: 156.w,
                  height: 50.h,
                  borderSide: BorderSide(
                    color: ThemeColors().secondaryColorOne,
                    width: 1,
                  ),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Expanded(
                child: PrimaryButton(
                  titleText: AppLocalizations.of(context)!.yesPlease,
                  onPressed: onYesPleasePressed,
                  backgroundColor: ThemeColors().secondaryColorTwo,
                  foregroundColor: ThemeColors().black,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  buttonRadius: 8.sp,
                  width: 156.w,
                  height: 50.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
