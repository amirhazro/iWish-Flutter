import 'package:flutter/material.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class PrimaryButton extends StatelessWidget {
  final String titleText;
  final VoidCallback onPressed;
  final Color foregroundColor;
  final Color backgroundColor;
  final double textSize;
  final FontWeight fontWeight;
  final double buttonRadius;
  final double width;
  final double height;
  final BorderSide borderSide;
  const PrimaryButton({
    super.key,
    required this.titleText,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.textSize,
    required this.fontWeight,
    required this.buttonRadius,
    required this.width,
    required this.height,
    this.borderSide = BorderSide.none,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
            side: borderSide,
          ),
        ),
        onPressed: onPressed,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: TextWidget(
            text: titleText,
            fontSize: textSize,
            fontWeight: fontWeight,
            color: foregroundColor,
          ),
        ),
      ),
    );
  }
}
