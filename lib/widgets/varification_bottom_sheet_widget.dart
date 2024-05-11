import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class VarificationBottomSheet extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onProceed;

  const VarificationBottomSheet({
    super.key,
    required this.onCancel,
    required this.onProceed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 32.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            text: AppLocalizations.of(context)!.verificationNeeded,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: ThemeColors().black,
          ),
          SizedBox(
            height: 16.h,
          ),
          TextWidget(
            text: AppLocalizations.of(context)!.verificationNeededDetail,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: ThemeColors().black,
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
                  titleText: AppLocalizations.of(context)!.proceed,
                  onPressed: onProceed,
                  backgroundColor: ThemeColors().secondaryColorTwo,
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
}
