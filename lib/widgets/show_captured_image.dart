import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowCapturedImage extends StatelessWidget {
  final XFile image;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  const ShowCapturedImage(
      {super.key,
      required this.image,
      required this.onCancel,
      required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.file(
              File(image.path),
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
      ),
    );
  }
}
