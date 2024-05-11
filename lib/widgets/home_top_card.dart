import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class HomeTopCard extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  final String title;
  final String detail;
  final Color backgroundColor;

  const HomeTopCard({
    super.key,
    required this.iconPath,
    required this.onPressed,
    required this.title,
    required this.detail,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              iconPath,
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(
              height: 2.h,
            ),
            TextWidget(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ThemeColors().homeTopCardTextColor,
            ),
            SizedBox(
              height: 2.h,
            ),
            TextWidget(
              text: detail,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: ThemeColors().black,
            ),
          ],
        ),
      ),
    );
  }
}
