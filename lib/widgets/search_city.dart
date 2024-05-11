import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/complete_profile/models/city_view_model.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/input_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:twemoji/twemoji.dart';

class SearchCity extends StatelessWidget {
  final TextEditingController controller;
  final Function(String selectedCity, int selectedCityId, int countryId,
      {String? countryFlag}) onTapOfCity;
  final RxList<CityViewModel> lstData;
  final RxBool noCityDataAvailable;
  final FocusNode focusNode;
  final RxString hintText;
  final RxBool isLoading;
  final bool? isCountryShortRequired;
  const SearchCity({
    super.key,
    required this.controller,
    required this.onTapOfCity,
    required this.lstData,
    required this.isLoading,
    required this.focusNode,
    required this.hintText,
    this.isCountryShortRequired,
    required this.noCityDataAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.dismissKeyboard(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.sp),
          color: ThemeColors().white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 4.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: ThemeColors().greyAddress,
                borderRadius: BorderRadius.circular(100.sp),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(() => CustomInputField(
                  textEditingController: controller,
                  hintText: hintText.value,
                  focusNode: focusNode,
                  fieldTitle: AppLocalizations.of(context)!.searchCity,
                  isPasswordField: false,
                  textInputType: TextInputType.text,
                  // decoration: BoxDecoration(
                  //   color: ThemeColors().addressTextFieldBackgroundColor,
                  //   borderRadius: BorderRadius.circular(100.sp),
                  // ),
                  inputFormatData: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r"[a-zA-Z0-9\-()_\'\‘\’ ]")),
                  ],
                )),
            Expanded(
              child: Container(
                color: ThemeColors().white,
                child: Obx(
                  () => !isLoading.value
                      ? noCityDataAvailable.value
                          ? TextWidget(
                              text: "No city found!",
                              color: ThemeColors().homeTopCardTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            )
                          : ListView.builder(
                              itemCount: lstData.length,
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Utils.dismissKeyboard(context);
                                    String cityName;
                                    if (isCountryShortRequired ?? false) {
                                      cityName =
                                          "${lstData[index].cityName}, ${lstData[index].countryShortName}";
                                    } else {
                                      cityName = lstData[index].cityName;
                                    }
                                    onTapOfCity(cityName, lstData[index].cityId,
                                        lstData[index].countryId,
                                        countryFlag:
                                            lstData[index].countryFlag);
                                  },
                                  child: Container(
                                    color: ThemeColors().white,
                                    child: Row(
                                      children: [
                                        Twemoji(
                                          emoji: lstData[index].countryFlag,
                                          width: 30.w,
                                          height: 30.h,
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              TextWidget(
                                                text: lstData[index].cityName,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: ThemeColors()
                                                    .homeTopCardTextColor,
                                              ),
                                              TextWidget(
                                                text: lstData[index]
                                                    .countryShortName,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: ThemeColors()
                                                    .homeTopCardTextColor,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Container(
                                                color:
                                                    ThemeColors().greyDivider,
                                                height: 0.5,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                      : Center(
                          child: CircularProgressIndicator(
                            color: ThemeColors().primaryColorOne,
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
