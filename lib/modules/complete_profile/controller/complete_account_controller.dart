import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwish_flutter/global_controller/global_controller.dart';
import 'package:iwish_flutter/global_controller/spoken_langugae_controller.dart';
import 'package:iwish_flutter/models/spoken_language_modal.dart';
import 'package:iwish_flutter/modules/complete_profile/repository/complete_profile_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/custom_popup.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/image_picker_bottom_sheet.dart';
import 'package:iwish_flutter/widgets/snackbar_popup.dart';

class CompleteAccountController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  RxBool showHidePassword = false.obs;
  Rx<XFile?> imageOne = Rx<XFile?>(null);
  RxBool isProfilePicError = false.obs;
  RxBool isLoading = false.obs;
  Rx<String?> fnameError = Rx<String?>(null);
  Rx<String?> lnameError = Rx<String?>(null);
  Rx<String?> emailError = Rx<String?>(null);
  RxList<SpokenLanguageModal> lstLangugaeData = <SpokenLanguageModal>[].obs;
  final CompleteProfileRepository _repository = CompleteProfileRepository();
  FocusNode focusEmail = FocusNode();
  FocusNode focusFname = FocusNode();
  FocusNode focusLname = FocusNode();

  RxString fnameHintText =
      AppLocalizations.of(Get.context!)!.enterFirstName.obs;
  RxString lnameHintText = AppLocalizations.of(Get.context!)!.enterLastName.obs;
  RxString emailHintText = AppLocalizations.of(Get.context!)!.enterEmail.obs;

  bool isTripFlow = false;

  @override
  void onInit() {
    requestGetLangugaes();
    focusEmail.addListener(onFocusTextField);
    focusFname.addListener(onFocusTextField);
    focusLname.addListener(onFocusTextField);

    if (Get.arguments != null) {
      if (Get.arguments['isTripFlow'] != null) {
        isTripFlow = Get.arguments['isTripFlow'];
        print('isTripFlow-> $isTripFlow');
      }
    }

    addTextListener();
    super.onInit();
  }

  addTextListener() {
    emailController.addListener(() {
      if (emailController.text.isNotEmpty) {
        if (GetUtils.isEmail(emailController.text)) {
          emailError.value = null;
        }
      }
    });
    firstNameController.addListener(() {
      if (firstNameController.text.isNotEmpty) {
        fnameError.value = null;
      }
    });
    lastNameController.addListener(() {
      if (lastNameController.text.isNotEmpty) {
        lnameError.value = null;
      }
    });
  }

  void showImagePickerDialog(context) async {
    CustomBottomSheet.showCustomBottomSheet(
        context,
        ImagePickerBottomSheet(
            onPickFromGallary: () => pickFromGallary(),
            onPickFromCamera: () => pickFromCamera()));
  }

  @override
  void dispose() {
    focusEmail.removeListener(onFocusTextField);
    focusFname.removeListener(onFocusTextField);
    focusLname.removeListener(onFocusTextField);
    focusEmail.dispose();
    focusFname.dispose();
    focusLname.dispose();
    firstNameController.removeListener(() {});
    lastNameController.removeListener(() {});
    emailController.removeListener(() {});
    super.dispose();
  }

  void pickFromGallary() async {
    Get.back();
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (Utils.checkIfFileIsImageOrNot(pickedFile)) {
        int sizeInBytes = await pickedFile.length();
        double sizeInMB = sizeInBytes / (1024 * 1024);
        if (sizeInMB <= 6) {
          isProfilePicError.value = false;
          imageOne.value = pickedFile;
        } else {
          isProfilePicError.value = true;
          imageOne.value = null;
        }
      } else {
        SnackbarPopup.show('Only image files are allowed',
            isError: false, title: "Information");
      }
    }
  }

  void pickFromCamera() async {
    Get.back();
    try {
      final picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        int sizeInBytes = await pickedFile.length();
        double sizeInMB = sizeInBytes / (1024 * 1024);
        if (sizeInMB <= 6) {
          isProfilePicError.value = false;
          imageOne.value = pickedFile;
        } else {
          isProfilePicError.value = true;
          imageOne.value = null;
        }
      }
    } on PlatformException catch (ex) {
      CustomPopup.showCustomDialog(
        Get.context!,
        'Permission denied',
        '${ex.message}',
      );
    }
  }

  void onFocusTextField() {
    if (focusEmail.hasFocus) {
      emailHintText.value = '';
    } else {
      emailHintText.value = AppLocalizations.of(Get.context!)!.enterEmail;
    }
    if (focusFname.hasFocus) {
      fnameHintText.value = '';
    } else {
      fnameHintText.value = AppLocalizations.of(Get.context!)!.enterFirstName;
    }
    if (focusLname.hasFocus) {
      lnameHintText.value = '';
    } else {
      lnameHintText.value = AppLocalizations.of(Get.context!)!.enterLastName;
    }

    Get.find<SpokenLanguageController>().isVisible.value = false;
  }

  //API Section
  Future<void> requestGetLangugaes() async {
    isLoading.value = true;
    try {
      var res = await _repository.getLangugages();
      lstLangugaeData.addAll(res);
      lstLangugaeData.refresh();
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestPostProfileInformation() async {
    bool isError = false;
    if (firstNameController.text.isEmpty) {
      fnameError.value = "Please enter first name";
      isError = true;
    }
    if (lastNameController.text.isEmpty) {
      lnameError.value = "Please enter last name";
      isError = true;
    }
    if (emailController.text.isEmpty) {
      emailError.value = "Please enter email";
      isError = true;
    } else {
      if (!GetUtils.isEmail(emailController.text)) {
        emailError.value = "Please enter valid email";
        isError = true;
      }
    }

    if (isError) {
      return;
    }

    isLoading.value = true;
    try {
      var res = await _repository.postProfileInformation(
        emailController.text,
        firstNameController.text,
        lastNameController.text,
        Get.find<SpokenLanguageController>().getSelectedLangugaeIds(),
      );
      if (res.data != null) {
        Get.toNamed(Routes().getOtpEmail(), arguments: {
          'email': emailController.text,
          'isTripFlow': isTripFlow
        });
      }
    } catch (e) {
      SnackbarPopup.show(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestPostProfileImage(BuildContext context) async {
    if (imageOne.value == null) {
      CustomPopup.showCustomDialog(
          context, "Information", "Please select profile image.",
          buttonText: "Ok");
      return;
    }

    isLoading.value = true;
    try {
      var res =
          await _repository.postProfileImage(File(imageOne.value?.path ?? ''));
      if (res.data != null) {
        await StorageService()
            .writeString(Keys.UserPicture, res.data?.picture ?? '');

        Get.find<GlobalController>().updateUserData();
        if (isTripFlow) {
          Get.close(4);
        } else {
          Get.toNamed(
            Routes().getAddressScreen(),
          );
        }
      }
    } catch (e) {
      SnackbarPopup.show(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
