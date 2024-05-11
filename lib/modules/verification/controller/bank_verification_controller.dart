import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankVerficationController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountIBANController = TextEditingController();
  TextEditingController accountSwiftCodeController = TextEditingController();

  RxString accountNameError = ''.obs;
  RxString accountNumberError = ''.obs;
  RxString accountIBANError = ''.obs;
  RxString accountSwiftCodeError = ''.obs;
  RxString accountBankNameError = ''.obs;

  RxString accountAccountNameHintText = ''.obs;
  RxString accountNumberHintText = ''.obs;
  RxString accountIBANHintText = ''.obs;
  RxString accountSwiftCodeHintText = ''.obs;
  RxString accountBankNameHintText = ''.obs;
}
