import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class GenericBottomSheetDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPositiveFeedback;
  final VoidCallback onNegativeFeedback;
  final String positiveFeedbackText;
  final String negativeFeedbackText;

  const GenericBottomSheetDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.onPositiveFeedback,
      required this.onNegativeFeedback,
      required this.positiveFeedbackText,
      required this.negativeFeedbackText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextWidget(
          text: title,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: ThemeColors().black,
        ),
        SizedBox(
          height: 16.sp,
        ),
        TextWidget(
          text: description,
          color: ThemeColors().black,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
        SizedBox(
          height: 24.sp,
        ),
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                titleText: negativeFeedbackText,
                onPressed: onNegativeFeedback,
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
                titleText: positiveFeedbackText,
                onPressed: onPositiveFeedback,
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
    );
  }
}
