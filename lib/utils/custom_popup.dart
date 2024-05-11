import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomPopup {
  static void showCustomDialog(
      BuildContext context, String title, String information,
      {String? buttonText, VoidCallback? onPressed}) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 150),
      pageBuilder: (_, __, ___) {
        return CustomDialog(
          title: title,
          infomation: information,
          buttonText: buttonText ?? AppLocalizations.of(context)!.cancel,
          onPressed: onPressed,
        );
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: child,
          ),
        );
      },
    );
  }

  static void showCustomWidgetDialog(BuildContext context, Widget widget) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 150),
      pageBuilder: (_, __, ___) {
        return widget;
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: child,
          ),
        );
      },
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title;
  final String infomation;
  final String buttonText;
  final VoidCallback? onPressed;
  const CustomDialog({
    super.key,
    required this.title,
    required this.infomation,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: ThemeColors().primaryColorOne,
              radius: 25.sp,
              child: Image.asset(
                AppAssets.icInfoIcon,
                width: 36.w,
                height: 36.h,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            TextWidget(
              text: title,
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 12.h,
            ),
            TextWidget(
              text: infomation,
              color: ThemeColors().homeTopCardTextColor,
              fontSize: 12.sp,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PrimaryButton(
                  titleText: buttonText,
                  onPressed: onPressed ??
                      () {
                        Get.back();
                      },
                  backgroundColor: ThemeColors().primaryColorOne,
                  foregroundColor: ThemeColors().black,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  buttonRadius: Constant.buttonRadius.sp,
                  width: 150.w,
                  height: 40.h,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
