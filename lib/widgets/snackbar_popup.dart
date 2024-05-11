import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';

class SnackbarPopup {
  static SnackbarController? snackBarController;
  static void show(String message,
      {bool isError = true, String title = "Error"}) {
    if (snackBarController != null && Get.isSnackbarOpen) {
      snackBarController?.close(withAnimations: false);
    }
    snackBarController = Get.snackbar(title, message,
        colorText: ThemeColors().black,
        backgroundColor: ThemeColors().white,
        snackPosition: SnackPosition.TOP,
        icon: Icon(
          Icons.error,
          color: ThemeColors().errorRed,
        ),
        boxShadows: [
          const BoxShadow(
            color: Colors.grey,
            blurRadius: 14.0,
            spreadRadius: 2.0,
          ),
        ],
        margin: EdgeInsets.only(
          top: 12.sp,
          left: 8.sp,
          right: 8.sp,
        ));
  }
}
