import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iwish_flutter/modules/trips/controller/trip_detail_controller.dart';
import 'package:iwish_flutter/modules/trips/models/currencies_view_model.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/back_button.dart';
import 'package:iwish_flutter/widgets/error_text.dart';
import 'package:iwish_flutter/widgets/input_field_offer.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/search_city.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:twemoji/twemoji.dart';

class MakeOfferBottomSheet extends StatelessWidget {
  final TripDetailController controller;
  final VoidCallback onProceed, onCrossPressed;
  const MakeOfferBottomSheet(
      {super.key,
      required this.controller,
      required this.onProceed,
      required this.onCrossPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.dismissKeyboard(context),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TopBarBackButton(
                      iconPath: AppAssets.icBackCross,
                      width: 32.sp,
                      height: 32.sp,
                      iconWidth: 11.w,
                      iconHeight: 11.h,
                      onPressed: onCrossPressed,
                    ),
                  ),
                ],
              ),
              TextWidget(
                text: AppLocalizations.of(context)!.makeAnOffer,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: ThemeColors().black,
              ),
              SizedBox(
                height: 12.h,
              ),
              TextWidget(
                text: AppLocalizations.of(context)!.makeAnOfferDetails,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: ThemeColors().black,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24.h,
              ),
              Obx(() => CustomOfferInputField(
                    titleSize: 14.sp,
                    maxLength: 3,
                    isMandatory: true,
                    titleWeight: FontWeight.w500,
                    textEditingController: controller.expiaryTextController,
                    hintText: 'Hours',
                    errorMsg: controller.errorHoursErrorMsg.value,
                    fieldTitle: AppLocalizations.of(context)!.offerExpiry,
                    isTrailingTextRequired: true,
                    trailingText: AppLocalizations.of(context)!.hour,
                    textInputType:
                        const TextInputType.numberWithOptions(decimal: false),
                    inputFormatData: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
                    ],
                  )),
              Obx(() => CustomOfferInputField(
                    titleSize: 14,
                    titleWeight: FontWeight.w500,
                    isMandatory: true,
                    textEditingController:
                        controller.purchasedFromTextController,
                    hintText: AppLocalizations.of(context)!.enterStoreName,
                    fieldTitle: AppLocalizations.of(context)!.purchaseFrom,
                    isTrailingTextRequired: false,
                    errorMsg: controller.purchaseFromErrorMsg.value,
                    textInputType: TextInputType.text,
                    trailingText: AppLocalizations.of(context)!.hour,
                    inputFormatData: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Z0-9\-()_\'\‘\’ ]")),
                    ],
                  )),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        currenciesDropDownBox(
                          context,
                          AppLocalizations.of(context)!.currency,
                          controller.currency,
                          controller.lstCurrenciesData,
                          (value) {
                            controller.currencyErrorMsg.value = null;
                            controller.currency.value = value;
                          },
                        ),
                        Obx(
                          () => ErrorText(
                            text: controller.currencyErrorMsg.value,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Obx(
                      () => CustomOfferInputField(
                        titleSize: 14,
                        titleWeight: FontWeight.w500,
                        isMandatory: true,
                        textEditingController:
                            controller.productPriceTextController,
                        hintText: 'Enter product price',
                        errorMsg: controller.errorPriceErrorMsg.value,
                        fieldTitle: AppLocalizations.of(context)!.productPrice,
                        isTrailingTextRequired: false,
                        trailingText: AppLocalizations.of(context)!.usd,
                        textInputType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatData: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Obx(
                () => CustomOfferInputField(
                  titleSize: 14,
                  titleWeight: FontWeight.w500,
                  textEditingController: controller.myFeesTextController,
                  hintText: 'Enter your fee',
                  fieldTitle: AppLocalizations.of(context)!.myFees,
                  isMandatory: true,
                  isTrailingTextRequired: true,
                  errorMsg: controller.errorMyFeeErrorMsg.value,
                  trailingText: controller.currency.value?.currencyName ?? '',
                  textInputType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatData: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        dropDownBox(
                          context,
                          AppLocalizations.of(context)!.iWillDeliverItBy,
                          controller.setDelivery,
                          controller.deliveryOptions,
                          (value) {
                            controller.setDelivery.value = value ?? '';
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
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(child: Container())
                ],
              ),
              Obx(
                () => Visibility(
                  visible: controller.setDelivery.value.toLowerCase() ==
                      'Courier'.toLowerCase(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.h,
                      ),
                      TextWidget(
                        text: AppLocalizations.of(context)!
                            .shippingCostCalculater,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors().homeTopCardTextColor,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                CustomBottomSheet.showCustomBottomSheet(
                                  context,
                                  modalColor: ThemeColors().white,
                                  SearchCity(
                                    controller: controller.cityNameController,
                                    focusNode: controller.searchFocusNode,
                                    hintText: controller.searchHint,
                                    onTapOfCity: (value, value1, countryId,
                                        {String? countryFlag}) {
                                      Get.back();
                                      controller.lstCityData.clear();
                                      controller.cityNameController.text = '';

                                      controller.fromCityName.value = value;
                                      controller.fromCityId = value1;
                                      controller.fromCountryId = countryId;
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  shippingDropDownBox(
                                    context,
                                    AppLocalizations.of(context)!.from,
                                    controller.fromCityName,
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
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                CustomBottomSheet.showCustomBottomSheet(
                                  context,
                                  modalColor: ThemeColors().white,
                                  SearchCity(
                                    controller: controller.cityNameController,
                                    focusNode: controller.searchFocusNode,
                                    hintText: controller.searchHint,
                                    onTapOfCity: (value, value1, countryId,
                                        {String? countryFlag}) {
                                      Get.back();
                                      controller.lstCityData.clear();
                                      controller.cityNameController.text = '';

                                      controller.toCityName.value = value;
                                      controller.toCityId = value1;
                                      controller.toCountryId = countryId;
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  shippingDropDownBox(
                                    context,
                                    AppLocalizations.of(context)!.to,
                                    controller.toCityName,
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
                          ),
                        ],
                      ),
                      CustomOfferInputField(
                        titleSize: 14,
                        titleWeight: FontWeight.w500,
                        textEditingController: TextEditingController(),
                        hintText: AppLocalizations.of(context)!.weight,
                        fieldTitle: '',
                        isTrailingTextRequired: true,
                        trailingText: AppLocalizations.of(context)!.kG,
                        hintTextStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ThemeColors().black,
                        ),
                        textInputType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatData: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomOfferInputField(
                                  titleSize: 14,
                                  titleWeight: FontWeight.w500,
                                  textEditingController:
                                      TextEditingController(),
                                  hintText:
                                      AppLocalizations.of(context)!.height,
                                  fieldTitle: '',
                                  isTrailingTextRequired: false,
                                  trailingText:
                                      AppLocalizations.of(context)!.kG,
                                  hintTextStyle: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: ThemeColors().black,
                                  ),
                                  textInputType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatData: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9.]+')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomOfferInputField(
                                  titleSize: 14,
                                  titleWeight: FontWeight.w500,
                                  textEditingController:
                                      TextEditingController(),
                                  hintText: AppLocalizations.of(context)!.width,
                                  fieldTitle: '',
                                  isTrailingTextRequired: false,
                                  trailingText:
                                      AppLocalizations.of(context)!.kG,
                                  hintTextStyle: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: ThemeColors().black,
                                  ),
                                  textInputType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  inputFormatData: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9.]+')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => controller.isProceed.value
                  ? Container(
                      width: Get.width,
                      padding: EdgeInsets.all(8.sp),
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: ThemeColors().primaryColorOne,
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.sp))),
                      child: Center(
                        child: SizedBox(
                          width: 25.w,
                          height: 25.h,
                          child: CircularProgressIndicator(
                            color: ThemeColors().black,
                            strokeWidth: 1.5,
                          ),
                        ),
                      ),
                    )
                  : PrimaryButton(
                      titleText: AppLocalizations.of(context)!.proceed,
                      onPressed: onProceed,
                      backgroundColor: ThemeColors().primaryColorOne,
                      foregroundColor: ThemeColors().black,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      buttonRadius: 8.sp,
                      width: Get.width,
                      height: 50.h,
                      borderSide: BorderSide(
                        color: ThemeColors().secondaryColorOne,
                        width: 1,
                      ),
                    )),
            ],
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
        TextWidget(
          text: text,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: ThemeColors().homeTopCardTextColor,
        ),
        SizedBox(
          height: 8.sp,
        ),
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(
            vertical: 2.h,
          ),
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
                    color: ThemeColors().black,
                  ),
                  openMenuIcon: Image.asset(
                    AppAssets.icArrowRight,
                    width: 16.w,
                    height: 16.h,
                    color: ThemeColors().black,
                  ),
                ),
                hint: TextWidget(
                  text: 'Select Item',
                  fontSize: 14.sp,
                  color: ThemeColors().greyAddress,
                  fontWeight: FontWeight.normal,
                ),
                items: items
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: TextWidget(
                            text: item,
                            fontSize: 14.sp,
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

  Widget currenciesDropDownBox(
    context,
    String text,
    Rx<CurrenciesViewModel?> selectedValue,
    RxList<CurrenciesViewModel?> items,
    Function(CurrenciesViewModel?) callback,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextWidget(
              text: text,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ThemeColors().homeTopCardTextColor,
            ),
            TextWidget(
              text: ' *',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
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
            vertical: 2.h,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: ThemeColors().greyBorder,
            ),
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: DropdownButtonHideUnderline(
            child: Obx(
              () => DropdownButton2<CurrenciesViewModel>(
                isExpanded: true,
                isDense: false,
                iconStyleData: IconStyleData(
                  icon: Image.asset(
                    AppAssets.icArrowDownBlack,
                    width: 15.sp,
                    height: 15.sp,
                  ),
                  openMenuIcon: Image.asset(
                    AppAssets.icArrowRight,
                    width: 16.w,
                    height: 16.h,
                    color: ThemeColors().black,
                  ),
                ),
                hint: TextWidget(
                  text: 'Select Currency',
                  fontSize: 14.sp,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: ThemeColors().homeTopCardTextColor,
                  fontWeight: FontWeight.w500,
                ),
                items: items
                    .map((CurrenciesViewModel? item) =>
                        DropdownMenuItem<CurrenciesViewModel>(
                          value: item,
                          child: Row(
                            children: [
                              Twemoji(
                                emoji: item?.countryFlag ?? '',
                                width: 24.w,
                                height: 24.h,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              TextWidget(
                                text: item?.currencyName ?? '',
                                fontSize: 14.sp,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500,
                                color: ThemeColors().black,
                              ),
                            ],
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
                selectedItemBuilder: (context) {
                  return items
                      .map((CurrenciesViewModel? item) =>
                          DropdownMenuItem<CurrenciesViewModel>(
                            value: item,
                            child: Row(
                              children: [
                                TextWidget(
                                  text: item?.currencyName ?? '',
                                  fontSize: 14.sp,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeColors().black,
                                ),
                              ],
                            ),
                          ))
                      .toList();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget shippingDropDownBox(
      context, String hintText, Rx<String?> selectedValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: ThemeColors().greyBorder,
            ),
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => TextWidget(
                    text: selectedValue.value ?? hintText,
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  )),
              Image.asset(
                AppAssets.icArrowDown,
                width: 16.w,
                height: 16.h,
                color: ThemeColors().black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
