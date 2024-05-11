import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class ToFromWidget extends StatelessWidget {
  final String toCity, fromCity, toCountry, fromCountry;
  final String date;
  const ToFromWidget(
      {super.key,
      required this.toCity,
      required this.fromCity,
      required this.toCountry,
      required this.fromCountry,
      required this.date});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
    final GlobalKey<TooltipState> tooltipkey2 = GlobalKey<TooltipState>();

    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            constraints: BoxConstraints(maxWidth: 50.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tooltip(
                  key: tooltipkey,
                  message: fromCity,
                  decoration: BoxDecoration(
                    color: ThemeColors().greyBorder,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  textStyle: GoogleFonts.poppins(
                    color: ThemeColors().black,
                  ),
                  verticalOffset: 10,
                  triggerMode: TooltipTriggerMode.manual,
                  child: GestureDetector(
                    onTap: () {
                      tooltipkey.currentState?.ensureTooltipVisible();
                    },
                    child: TextWidget(
                      text: fromCity,
                      color: ThemeColors().black,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                TextWidget(
                  text: fromCountry,
                  color: ThemeColors().black,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w300,
                  fontSize: 13.sp,
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.icOffersCircularDot,
              width: 16.w,
              height: 16.h,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AppAssets.icOffersDivider,
                  width: 129.w,
                  height: 12.h,
                  fit: BoxFit.fitWidth,
                ),
                Column(
                  children: [
                    Image.asset(AppAssets.icOffersPlane,
                        width: 10.w, height: 10.h),
                    SizedBox(
                      height: 4.h,
                    ),
                    TextWidget(
                        text:
                            DateFormat('MMM, dd').format(DateTime.parse(date)),
                        color: ThemeColors().black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp)
                  ],
                ),
              ],
            ),
            Image.asset(
              AppAssets.icOffersCircularDot,
              width: 16.w,
              height: 16.h,
            ),
          ],
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Container(
            constraints: BoxConstraints(maxWidth: 50.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tooltip(
                  key: tooltipkey2,
                  message: toCity,
                  decoration: BoxDecoration(
                    color: ThemeColors().greyBorder,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  textStyle: GoogleFonts.poppins(
                    color: ThemeColors().black,
                  ),
                  verticalOffset: 10,
                  triggerMode: TooltipTriggerMode.manual,
                  child: GestureDetector(
                    onTap: () {
                      tooltipkey2.currentState?.ensureTooltipVisible();
                    },
                    child: TextWidget(
                      text: toCity,
                      color: ThemeColors().black,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                TextWidget(
                  text: toCountry,
                  color: ThemeColors().black,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w300,
                  fontSize: 13.sp,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
