import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class ErrorText extends StatelessWidget {
  final String? text;
  final bool maintainState;
  const ErrorText({
    super.key,
    required this.text,
    this.maintainState = true,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: text != null,
      maintainState: maintainState,
      maintainAnimation: maintainState,
      maintainSize: maintainState,
      child: TextWidget(
        text: text ?? '',
        fontSize: 12.sp,
        color: ThemeColors().errorRed,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
