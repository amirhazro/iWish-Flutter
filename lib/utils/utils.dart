import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iwish_flutter/utils/custom_popup.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/widgets/snackbar_popup.dart';
import 'package:path_provider/path_provider.dart';

import '../services/storage_service.dart';

class Utils {
  static void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<File> downloadAndSaveImage(String url, String imageName) async {
    final response = await http.get(Uri.parse(url));
    final Uint8List bytes = response.bodyBytes;

    final directory = await getApplicationDocumentsDirectory();

    final File imageFile = File('${directory.path}/$imageName.png');
    await imageFile.writeAsBytes(bytes);
    return imageFile;
  }

  static void showNoInternetWarning() {
    SnackbarPopup.show('No Internet Connection');
  }

  static bool isValidPhoneNumber(String? value) =>
      RegExp(r'^\+[1-9]{1}[0-9]{8,16}$').hasMatch(value ?? '');
  static bool isValidEmail(String? value) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value ?? '');

  static late CameraDescription cameraDescription;

  static void showSessionExpiredPopup() {
    CustomPopup.showCustomDialog(
      Get.overlayContext!,
      "Session Expired",
      "Your session has expired. Please sign in again.",
      buttonText: "OK",
      onPressed: () async {
        await StorageService().clearData();
        Get.offAllNamed(Routes().getSplashPage());
      },
    );
  }

  static String timeDifference(DateTime startTime, DateTime endTime) {
    // Calculate the time difference
    Duration difference = endTime.difference(startTime);

    // Extract hours, minutes, and seconds from the difference
    int days = difference.inDays;
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    if (days > 0) {
      return days > 1 ? '$days days' : '$days day';
    }
    if (hours > 0) {
      return hours > 1 ? '$hours hrs' : '$hours hr';
    } else {
      return minutes > 1 ? '$minutes mins' : '$minutes min';
    }
  }

  static bool checkIfFileIsImageOrNot(XFile pickedFile) {
    String filePath = pickedFile.path;
    String extension = filePath.split('.').last.toLowerCase();
    debugPrint(extension);
    if (extension == 'mp4' ||
        extension == 'mov' ||
        extension == 'avi' ||
        extension == 'mkv' ||
        extension == '3gp' ||
        extension == 'wmv' ||
        extension == 'webm' ||
        extension == 'mpeg' ||
        extension == 'flv' ||
        extension == 'gif' ||
        extension == 'mpg' ||
        extension == 'ogg') {
      return false;
    }
    return true;
  }
}
