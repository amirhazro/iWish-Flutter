import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwish_flutter/utils/app_assets.dart';

import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/input_field.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewBottomSheet extends StatelessWidget {
  final VoidCallback onCancelPressed;
  final VoidCallback onYesPleasePressed;
  final String titleOne;
  final String titleTwo;
  final TextEditingController textControllerOne;
  final TextEditingController textControllerTwo;
  final void Function(double) onRatingChangeOne;
  final void Function(double) onRatingChangeTwo;
  const ReviewBottomSheet(
      {super.key,
      required this.onCancelPressed,
      required this.onYesPleasePressed,
      required this.titleOne,
      required this.titleTwo,
      required this.textControllerOne,
      required this.textControllerTwo,
      required this.onRatingChangeOne,
      required this.onRatingChangeTwo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.dismissKeyboard(context),
      child: Container(
        color: ThemeColors().transparent,
        margin: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 32.h,
        ),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(
                    text: titleOne,
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: RatingBar.builder(
                      onRatingUpdate: onRatingChangeOne,
                      itemPadding: EdgeInsets.symmetric(horizontal: 6.w),
                      unratedColor: ThemeColors().brightGray,
                      itemBuilder: (context, index) => Image.asset(
                        AppAssets.icRating,
                      ),
                      itemCount: 5,
                      itemSize: 20,
                      direction: Axis.horizontal,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              CustomInputField(
                textEditingController: textControllerOne,
                hintText: '',
                fieldTitle: '',
                isPasswordField: false,
                textInputType: TextInputType.text,
                maxLines: 4,
                minLines: 4,
                inputFormatData: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r"[a-zA-Z0-9\-()_.\'\‘\’ ]")),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: titleTwo,
                    color: ThemeColors().black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: RatingBar.builder(
                      onRatingUpdate: onRatingChangeTwo,
                      itemPadding: EdgeInsets.symmetric(horizontal: 6.w),
                      unratedColor: ThemeColors().brightGray,
                      itemBuilder: (context, index) => Image.asset(
                        AppAssets.icRating,
                      ),
                      itemCount: 5,
                      itemSize: 20,
                      direction: Axis.horizontal,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              CustomInputField(
                textEditingController: textControllerTwo,
                hintText: '',
                fieldTitle: '',
                isPasswordField: false,
                textInputType: TextInputType.text,
                maxLines: 4,
                minLines: 4,
                inputFormatData: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r"[a-zA-Z0-9\-()_.\'\‘\’ ]")),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      titleText: AppLocalizations.of(context)!.cancel,
                      onPressed: onCancelPressed,
                      backgroundColor: ThemeColors().transparent,
                      foregroundColor: ThemeColors().black,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      buttonRadius: 8.sp,
                      width: 156.w,
                      height: 50.h,
                      borderSide: BorderSide(
                        color: ThemeColors().secondaryColorOne,
                        width: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: PrimaryButton(
                      titleText: AppLocalizations.of(context)!.rateUs,
                      onPressed: onYesPleasePressed,
                      backgroundColor:
                          ThemeColors().toggleSwitchBackgroundColorActive,
                      foregroundColor: ThemeColors().black,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      buttonRadius: 8.sp,
                      width: 156.w,
                      height: 50.h,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
