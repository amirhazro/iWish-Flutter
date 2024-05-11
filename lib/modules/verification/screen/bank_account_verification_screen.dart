import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/verification/controller/bank_verification_controller.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/input_field.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class BankAccountVerificationScreen extends StatelessWidget {
  static const id = '/BankAccountVerificationScreen';
  final controller = Get.find<BankVerficationController>();
  BankAccountVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                TextWidget(
                  text: 'Bank Account Verification',
                  color: ThemeColors().black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
                SizedBox(
                  height: 24.h,
                ),
                TextWidget(
                  text:
                      'Enter your bank account details for verification purposes',
                  color: ThemeColors().black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  textAlign: TextAlign.center,
                  height: 1.5,
                ),
                SizedBox(
                  height: 50.h,
                ),
                CustomInputField(
                  textEditingController: controller.accountNameController,
                  hintText: 'Enter name',
                  fieldTitle: 'Account Holder Name',
                  isPasswordField: false,
                  textInputType: TextInputType.text,
                ),
                CustomInputField(
                  textEditingController: controller.accountNameController,
                  hintText: 'Enter name',
                  fieldTitle: 'Account Number',
                  isPasswordField: false,
                  textInputType: TextInputType.text,
                ),
                CustomInputField(
                  textEditingController: controller.accountNameController,
                  hintText: 'Enter name',
                  fieldTitle: 'IBAN',
                  isPasswordField: false,
                  textInputType: TextInputType.text,
                ),
                CustomInputField(
                  textEditingController: controller.accountNameController,
                  hintText: 'Enter name',
                  fieldTitle: 'Swift Code',
                  isPasswordField: false,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 50.h,
                ),
                PrimaryButton(
                  titleText: 'Verify Bank Account',
                  onPressed: () {},
                  backgroundColor: ThemeColors().black,
                  foregroundColor: ThemeColors().white,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  buttonRadius: 8.sp,
                  width: Get.width,
                  height: 51.h,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
