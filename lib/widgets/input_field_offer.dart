import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/error_text.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';

class CustomOfferInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String fieldTitle;
  final bool isTrailingTextRequired;
  final bool? obsecureText;
  final VoidCallback? onShowHideIconPressed;
  final TextInputType textInputType;
  final BoxDecoration? decoration;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final String? errorMsg;
  final int? maxLines;
  final int? minLines;
  final bool isEnable;
  final double titleSize;
  final FontWeight? titleWeight;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final Color? titleColor;
  final List<TextInputFormatter>? inputFormatData;
  final String? trailingText;
  final int? maxLength;
  final bool isMandatory;

  const CustomOfferInputField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.fieldTitle,
    required this.isTrailingTextRequired,
    this.obsecureText,
    this.onShowHideIconPressed,
    required this.textInputType,
    this.decoration,
    this.autoFocus,
    this.focusNode,
    this.errorMsg,
    this.maxLines,
    this.minLines,
    this.isEnable = true,
    this.titleColor,
    this.titleSize = 14,
    this.titleWeight,
    this.inputFormatData,
    this.trailingText,
    this.hintTextStyle,
    this.textStyle,
    this.maxLength,
    this.isMandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fieldTitle.isNotEmpty)
          Row(
            children: [
              TextWidget(
                text: fieldTitle,
                fontSize: titleSize.sp,
                fontWeight: titleWeight ?? FontWeight.w500,
                color: titleColor ?? ThemeColors().homeTopCardTextColor,
              ),
              if (isMandatory)
                TextWidget(
                  text: ' *',
                  fontSize: titleSize.sp,
                  fontWeight: titleWeight ?? FontWeight.w500,
                  color: titleColor ?? ThemeColors().errorRed,
                ),
            ],
          ),
        if (fieldTitle.isNotEmpty)
          SizedBox(
            height: 8.sp,
          ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 6.h,
          ),
          decoration: decoration ??
              BoxDecoration(
                border: Border.all(
                  color: ThemeColors().greyBorder,
                ),
                borderRadius: BorderRadius.circular(12.sp),
              ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  enabled: isEnable,
                  maxLength: maxLength,
                  controller: textEditingController,
                  keyboardType: textInputType,
                  focusNode: focusNode,
                  maxLines: maxLines ?? 1,
                  minLines: minLines,
                  style: textStyle ??
                      GoogleFonts.poppins(
                        color: isEnable
                            ? ThemeColors().homeTopCardTextColor
                            : ThemeColors().grey.withOpacity(0.7),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    counterText: '',
                    isDense: true,
                    hintStyle: hintTextStyle ??
                        GoogleFonts.poppins(
                          color: ThemeColors().greyAddress,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  autofocus: autoFocus ?? false,
                  inputFormatters: [
                    RemoveEmojiInputFormatter(),
                    ...inputFormatData ?? []
                  ],
                ),
              ),
              if (isTrailingTextRequired)
                TextWidget(
                  text: trailingText ?? '',
                  color: ThemeColors().homeTopCardTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                )
            ],
          ),
        ),
        ErrorText(text: errorMsg),
        SizedBox(
          height: 8.h,
        )
      ],
    );
  }
}
