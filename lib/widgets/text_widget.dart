import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? height;
  const TextWidget({
    super.key,
    required this.text,
    this.overflow,
    this.maxLines,
    this.height,
    this.textAlign,
    required this.color,
    required this.fontWeight,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: Get.locale?.languageCode == 'en'
          ? GoogleFonts.poppins(
              fontSize: fontSize,
              color: color,
              fontWeight: fontWeight,
              height: height)
          : GoogleFonts.cairo(
              fontSize: fontSize,
              color: color,
              fontWeight: fontWeight,
              height: height,
            ),
    );
  }
}
