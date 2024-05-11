import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iwish_flutter/modules/add_trip/controller/add_trip_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/custom_popup.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:iwish_flutter/widgets/date_picker_bottom_sheet.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:twemoji/twemoji.dart';

import '../../../utils/bottom_sheet.dart';
import '../../../widgets/search_city.dart';

// ignore: must_be_immutable
class AddYourTripScreen extends StatelessWidget {
  static const id = '/AddYourTripScreen';
  var controller = Get.find<AddTripController>();
  AddYourTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return LoadingOverlay(
          isLoading: controller.isLoading.value,
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
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        TextWidget(
                          text: AppLocalizations.of(context)!.addYourTrip,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
                          color: ThemeColors().black,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextWidget(
                          text: AppLocalizations.of(context)!.addYourTripInfo,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          color: ThemeColors().grey,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => PrimaryButton(
                                  titleText:
                                      AppLocalizations.of(context)!.oneWay,
                                  onPressed: () {
                                    controller.selectedDate.value = '';
                                    controller.selectedYear.value = '';
                                    controller.departureDate = null;
                                    controller.returnDate = null;
                                    controller.isRoundTrip.value = false;
                                  },
                                  backgroundColor: !controller.isRoundTrip.value
                                      ? ThemeColors().primaryColorOne
                                      : ThemeColors().greySocialButtons,
                                  foregroundColor: ThemeColors().black,
                                  textSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  buttonRadius: 8.sp,
                                  width: Get.width,
                                  height: 46.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.sp,
                            ),
                            Expanded(
                              child: Obx(
                                () => PrimaryButton(
                                  titleText:
                                      AppLocalizations.of(context)!.roundTrip,
                                  onPressed: () {
                                    controller.selectedDate.value = '';
                                    controller.selectedYear.value = '';
                                    controller.departureDate = null;
                                    controller.returnDate = null;
                                    controller.isRoundTrip.value = true;
                                  },
                                  backgroundColor: controller.isRoundTrip.value
                                      ? ThemeColors().primaryColorOne
                                      : ThemeColors().greySocialButtons,
                                  foregroundColor: ThemeColors().black,
                                  textSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  buttonRadius: 8.sp,
                                  width: Get.width,
                                  height: 46.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Stack(
                          children: [
                            Positioned(
                              top: 50.h,
                              child: Image.asset(
                                AppAssets.icTripToFrom,
                                height: 118.sp,
                                width: 16.sp,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 30.w,
                              ),
                              child: Column(
                                children: [
                                  Obx(
                                    () => fromAndToWidget(
                                      context,
                                      AppLocalizations.of(context)!.from,
                                      controller.selectedFromCity.value,
                                      controller.selectedFromFlag.value,
                                      () {
                                        controller.cityNameController.text = '';
                                        showCityBottomSheet(context,
                                            (cityName, cityId, countryId,
                                                {countryFlag}) {
                                          Get.back();

                                          if (cityId == controller.toCityId &&
                                              countryId ==
                                                  controller.toCountryId) {
                                            controller.selectedToCity.value =
                                                '';
                                            controller.selectedToFlag.value =
                                                '';

                                            controller.toCityId = null;
                                            controller.toCountryId = null;
                                          }

                                          controller.selectedFromCity.value =
                                              cityName;
                                          controller.selectedFromFlag.value =
                                              countryFlag ?? '🌏';

                                          controller.fromCityId = cityId;
                                          controller.fromCountryId = countryId;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  Obx(
                                    () => fromAndToWidget(
                                      context,
                                      AppLocalizations.of(context)!.to,
                                      controller.selectedToCity.value,
                                      controller.selectedToFlag.value,
                                      () {
                                        controller.cityNameController.text = '';
                                        showCityBottomSheet(context,
                                            (cityName, cityId, countryId,
                                                {countryFlag}) {
                                          Get.back();

                                          if (cityId == controller.fromCityId &&
                                              countryId ==
                                                  controller.fromCountryId) {
                                            CustomPopup.showCustomDialog(
                                                context,
                                                'Error',
                                                ' Please select a different destination.');
                                            return;
                                          }

                                          controller.selectedToCity.value =
                                              cityName;
                                          controller.selectedToFlag.value =
                                              countryFlag ?? '🌏';

                                          controller.toCityId = cityId;
                                          controller.toCountryId = countryId;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Obx(
                          () => travelDateWidget(
                            context,
                            AppLocalizations.of(context)!.travelDate,
                            controller.selectedDate.value,
                            controller.selectedYear.value,
                            () {
                              CustomBottomSheet.showDatePickerBottomSheet(
                                context,
                                modalColor: ThemeColors().white,
                                DatePickerBottomSheet(
                                    minDate: DateTime.now(),
                                    onConfirm: (value) {
                                      if (value != null) {
                                        if (value is PickerDateRange) {
                                          if (value.startDate != null &&
                                              value.endDate != null) {
                                            controller.selectedDate.value =
                                                '${DateFormat('MMM dd').format(value.startDate ?? DateTime.now())} ~ ${DateFormat('MMM dd').format(value.endDate ?? DateTime.now())}';
                                            if (DateFormat('yyyy').format(
                                                    value.startDate ??
                                                        DateTime.now()) ==
                                                DateFormat('yyyy').format(
                                                    value.endDate ??
                                                        DateTime.now())) {
                                              controller.selectedYear.value =
                                                  DateFormat('yyyy').format(
                                                      value.startDate ??
                                                          DateTime.now());
                                            } else {
                                              controller.selectedYear.value =
                                                  '${DateFormat('yyyy').format(value.startDate ?? DateTime.now())} ~ ${DateFormat('yyyy').format(value.endDate ?? DateTime.now())}';
                                            }

                                            controller.initialDateRange.value =
                                                value;

                                            controller.departureDate =
                                                value.startDate;
                                            controller.returnDate =
                                                value.endDate;
                                          } else {
                                            CustomPopup.showCustomDialog(
                                                context,
                                                'Missing information',
                                                ' Please select the both departure and return date');
                                            return;
                                          }
                                        } else {
                                          controller.departureDate =
                                              value ?? DateTime.now();
                                          controller.returnDate = null;
                                          controller.selectedDate.value =
                                              DateFormat('MMM dd').format(
                                                  value ?? DateTime.now());
                                          controller.selectedYear.value =
                                              DateFormat('yyyy').format(
                                                  value ?? DateTime.now());

                                          controller.initialSelectedDate.value =
                                              value;
                                        }
                                      }
                                      Get.back();
                                    },
                                    initialSelectedDate:
                                        controller.initialSelectedDate,
                                    initialSelectedRange:
                                        controller.initialDateRange,
                                    mode: controller.isRoundTrip.value
                                        ? DateRangePickerSelectionMode.range
                                        : DateRangePickerSelectionMode.single),
                                constraints: BoxConstraints(
                                  maxHeight: Get.height * 0.9,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  PrimaryButton(
                    titleText: AppLocalizations.of(context)!.done,
                    onPressed: controller.requestPostTripData,
                    backgroundColor: ThemeColors().primaryColorOne,
                    foregroundColor: ThemeColors().black,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    buttonRadius: 8.sp,
                    width: Get.width,
                    height: 50.h,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget fromAndToWidget(BuildContext context, String title, String cityValue,
      String flagValue, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextWidget(
              text: title,
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
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: ThemeColors().white,
              border: Border.all(
                color: ThemeColors().greyBorder,
              ),
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: cityValue,
                  color:
                      cityValue == AppLocalizations.of(context)!.enterCityName
                          ? ThemeColors().greyAddress
                          : ThemeColors().homeTopCardTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                ),
                Twemoji(
                  emoji: flagValue,
                  width: 18.w,
                  height: 18.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget travelDateWidget(
    BuildContext context,
    String title,
    String date,
    String year,
    VoidCallback onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextWidget(
              text: title,
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
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: ThemeColors().white,
              border: Border.all(
                color: ThemeColors().greyBorder,
              ),
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: date.isEmpty && year.isEmpty
                      ? TextWidget(
                          text:
                              AppLocalizations.of(context)!.selectTravelingDate,
                          color: ThemeColors().greyAddress,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        )
                      : Row(
                          children: [
                            TextWidget(
                              text: date,
                              color: ThemeColors().homeTopCardTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Container(
                              width: 0.5.sp,
                              height: 10.sp,
                              color: ThemeColors().greyDivider,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            TextWidget(
                              text: year,
                              color: ThemeColors().homeTopCardTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp,
                            ),
                          ],
                        ),
                ),
                Image.asset(
                  AppAssets.icTravelCalenderIcon,
                  width: 18.w,
                  height: 18.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  showCityBottomSheet(
      BuildContext context,
      Function(String cityName, int cityId, int countryId,
              {String? countryFlag})
          onTapCity) {
    CustomBottomSheet.showCustomBottomSheet(
      context,
      modalColor: ThemeColors().white,
      SearchCity(
        controller: controller.cityNameController,
        focusNode: controller.searchFocusNode,
        hintText: controller.searchHint,
        onTapOfCity: onTapCity,
        lstData: controller.lstCityData,
        isLoading: controller.isCityLoading,
        isCountryShortRequired: true,
        noCityDataAvailable: controller.noCityDataAvailable,
      ),
      constraints: BoxConstraints(
        maxHeight: Get.height * 0.9,
      ),
    );
  }
}
