import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/modules/complete_profile/controller/address_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:iwish_flutter/widgets/error_text.dart';
import 'package:iwish_flutter/widgets/input_field.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:iwish_flutter/widgets/search_city.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import '../../../widgets/primary_button.dart';

// ignore: must_be_immutable
class AddressScreen extends StatelessWidget {
  static const id = '/AddressScreen';
  AddressScreen({super.key});
  var controller = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: GestureDetector(
          onTap: () => Utils.dismissKeyboard(context),
          child: Scaffold(
            backgroundColor: ThemeColors().white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.h),
              child: CustomSecondaryAppBar(
                title: '',
                onBackPressed: () {
                  Get.back();
                },
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: AppLocalizations.of(context)!.addAddress,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: ThemeColors().black,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextWidget(
                            text:
                                AppLocalizations.of(context)!.addAddressDetail,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: ThemeColors().greyAddress,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: Image.asset(
                              AppAssets.icAddressIllustration,
                              width: 100.w,
                              height: 100.h,
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: TextWidget(
                              text: AppLocalizations.of(context)!.myAddress,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: ThemeColors().black,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextWidget(
                            text: AppLocalizations.of(context)!
                                .addressInformationTwo,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: ThemeColors().greyAddress,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          CustomInputField(
                            isMandatory: true,
                            textEditingController: controller.addressName,
                            focusNode: controller.focusAddressName,
                            hintText: controller.addressNameHintText.value,
                            errorMsg: controller.addressNameError.value,
                            titleSize: 12,
                            titleWeight: FontWeight.w600,
                            titleColor: ThemeColors().blackVersionTwo,
                            fieldTitle:
                                AppLocalizations.of(context)!.addressName,
                            isPasswordField: false,
                            textInputType: TextInputType.text,
                            // decoration: BoxDecoration(
                            //   color:
                            //       ThemeColors().addressTextFieldBackgroundColor,
                            //   borderRadius: BorderRadius.circular(100.sp),
                            // ),
                            inputFormatData: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z0-9\-()_\'\‘\’ ]")),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomInputField(
                            isMandatory: true,
                            textEditingController: controller.streetAddress,
                            focusNode: controller.focusStreetAddress,
                            hintText: controller.streetAddressHintText.value,
                            errorMsg: controller.streetAddressError.value,
                            titleSize: 12,
                            titleWeight: FontWeight.w600,
                            titleColor: ThemeColors().blackVersionTwo,
                            fieldTitle:
                                AppLocalizations.of(context)!.streetAddress,
                            isPasswordField: false,
                            textInputType: TextInputType.text,
                            // decoration: BoxDecoration(
                            //   color:
                            //       ThemeColors().addressTextFieldBackgroundColor,
                            //   borderRadius: BorderRadius.circular(100.sp),
                            // ),
                            inputFormatData: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z0-9\-()_.,\'\‘\’ ]")),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    CustomBottomSheet.showCustomBottomSheet(
                                      context,
                                      modalColor: ThemeColors().white,
                                      SearchCity(
                                        controller:
                                            controller.cityNameController,
                                        focusNode: controller.searchFocusNode,
                                        hintText: controller.searchHint,
                                        onTapOfCity: (value, value1, countryId,
                                            {String? countryFlag}) {
                                          Get.back();
                                          controller.lstCityData.clear();
                                          controller.cityNameController.text =
                                              '';
                                          controller.cityName.value = value;
                                          controller.city_id = value1;
                                          controller.country_id = countryId;
                                          if (controller.city_id != -1) {
                                            controller.cityNameError.value =
                                                null;
                                          }
                                        },
                                        lstData: controller.lstCityData,
                                        isLoading: controller.isCityLoading,
                                        noCityDataAvailable:
                                            controller.noCityDataAvailable,
                                      ),
                                      constraints: BoxConstraints(
                                        maxHeight: Get.height * 0.9,
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      cityWidget(
                                        context,
                                        AppLocalizations.of(context)!.cityName,
                                        controller.cityName,
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Obx(
                                        () => ErrorText(
                                          text: controller.cityNameError.value,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomInputField(
                                      isMandatory: true,
                                      textEditingController:
                                          controller.stateName,
                                      focusNode: controller.focusStateName,
                                      hintText:
                                          controller.stateNameHintText.value,
                                      errorMsg: controller.stateNameError.value,
                                      titleSize: 12,
                                      titleWeight: FontWeight.w600,
                                      titleColor: ThemeColors().blackVersionTwo,
                                      fieldTitle: AppLocalizations.of(context)!
                                          .stateName,
                                      isPasswordField: false,
                                      textInputType: TextInputType.text,
                                      // decoration: BoxDecoration(
                                      //   color: ThemeColors()
                                      //       .addressTextFieldBackgroundColor,
                                      //   borderRadius:
                                      //       BorderRadius.circular(100.sp),
                                      // ),
                                      inputFormatData: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r"[a-zA-Z0-9\-()_\'\‘\’ ]")),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomInputField(
                                      isMandatory: true,
                                      focusNode: controller.focusZipCode,
                                      hintText:
                                          controller.zipCodeHintText.value,
                                      textEditingController: controller.zipCode,
                                      errorMsg: controller.zipCodeError.value,
                                      titleSize: 12,
                                      titleWeight: FontWeight.w600,
                                      titleColor: ThemeColors().blackVersionTwo,
                                      fieldTitle:
                                          AppLocalizations.of(context)!.zipcode,
                                      isPasswordField: false,
                                      textInputType: TextInputType.text,

                                      // decoration: BoxDecoration(
                                      //   color: ThemeColors()
                                      //       .addressTextFieldBackgroundColor,
                                      //   borderRadius:
                                      //       BorderRadius.circular(100.sp),
                                      // ),
                                      inputFormatData: [
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^[a-zA-Z0-9\- ]{0,10}$',
                                                caseSensitive: false))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    dropDownBox(
                                      context,
                                      AppLocalizations.of(context)!.setAs,
                                      controller.setAs,
                                      controller.addressType,
                                      (value) {
                                        controller.setAs.value = value ?? '';
                                      },
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    const ErrorText(
                                      text: '',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          PrimaryButton(
                            titleText: AppLocalizations.of(context)!.finalize,
                            onPressed: controller.requestPostAddressInformation,
                            backgroundColor: ThemeColors().primaryColorOne,
                            foregroundColor: ThemeColors().black,
                            textSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            buttonRadius: Constant.buttonRadius,
                            width: Get.width,
                            height: 50.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownBox(context, String text, RxString selectedValue,
      List<String> items, Function(String?) callback) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextWidget(
              text: text,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: ThemeColors().blackVersionTwo,
            ),
            TextWidget(
              text: ' *',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: ThemeColors().errorRed,
            ),
          ],
        ),
        SizedBox(
          height: 8.sp,
        ),
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(
            vertical: 3.h,
          ),
          // decoration: BoxDecoration(
          //   color: ThemeColors().addressTextFieldBackgroundColor,
          //   borderRadius: BorderRadius.circular(100.sp),
          // ),
          decoration: BoxDecoration(
            border: Border.all(
              color: ThemeColors().greyBorder,
            ),
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: DropdownButtonHideUnderline(
            child: Obx(
              () => DropdownButton2<String>(
                isExpanded: true,
                isDense: false,
                iconStyleData: IconStyleData(
                  icon: Image.asset(
                    AppAssets.icArrowDown,
                    width: 16.w,
                    height: 16.h,
                    color: ThemeColors().toggleSwitchBackgroundColorActive,
                  ),
                  openMenuIcon: Image.asset(
                    AppAssets.icArrowRight,
                    width: 16.w,
                    height: 16.h,
                    color: ThemeColors().toggleSwitchBackgroundColorActive,
                  ),
                ),
                hint: TextWidget(
                  text: 'Select Item',
                  fontSize: 12.sp,
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.normal,
                ),
                items: items
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: TextWidget(
                            text: item,
                            fontSize: 12.sp,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            color: ThemeColors().blackVersionTwo,
                          ),
                        ))
                    .toList(),
                value: selectedValue.value,
                onChanged: callback,
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget cityWidget(BuildContext context, String text, RxString selectedValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextWidget(
              text: text,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: ThemeColors().blackVersionTwo,
            ),
            TextWidget(
              text: ' *',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: ThemeColors().errorRed,
            ),
          ],
        ),
        SizedBox(
          height: 8.sp,
        ),
        Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            // decoration: BoxDecoration(
            //   color: ThemeColors().addressTextFieldBackgroundColor,
            //   borderRadius: BorderRadius.circular(100.sp),
            // ),
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeColors().greyBorder,
              ),
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(
                    () => TextWidget(
                      text: selectedValue.value,
                      color: selectedValue.value ==
                              AppLocalizations.of(context)!.enterCityName
                          ? ThemeColors().greyAddress
                          : ThemeColors().homeTopCardTextColor,
                      fontSize: 13.sp,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Image.asset(
                  AppAssets.icArrowDown,
                  width: 16.w,
                  height: 16.h,
                  color: ThemeColors().toggleSwitchBackgroundColorActive,
                ),
              ],
            )),
      ],
    );
  }
}
