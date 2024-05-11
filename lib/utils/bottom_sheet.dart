import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/global_controller/date_range_picker_controller.dart';
import 'package:iwish_flutter/utils/colors.dart';

class CustomBottomSheet {
  static void showCustomBottomSheet(context, Widget widget,
      {BoxConstraints? constraints,
      Color? modalColor,
      bool enableDrag = true}) async {
    modalColor ??= ThemeColors().white;
    await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: enableDrag,
      barrierColor:
          ThemeColors().modalBackgroundBottomSheetColor.withOpacity(0.85),
      backgroundColor: modalColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            12.sp,
          ),
        ),
      ),
      constraints: constraints,
      context: context,
      builder: (context) {
        return widget;
      },
    );
  }

  static void showDatePickerBottomSheet(context, Widget widget,
      {BoxConstraints? constraints,
      Color? modalColor,
      bool enableDrag = true}) async {
    modalColor ??= ThemeColors().white;

    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: enableDrag,
      barrierColor:
          ThemeColors().modalBackgroundBottomSheetColor.withOpacity(0.85),
      backgroundColor: modalColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            12.sp,
          ),
        ),
      ),
      constraints: constraints,
      context: context,
      builder: (context) {
        return widget;
      },
    ).whenComplete(() {
      if (Get.isRegistered<CustomDateRangePickerController>()) {
        Get.delete<CustomDateRangePickerController>();
      }
    });
  }
}
