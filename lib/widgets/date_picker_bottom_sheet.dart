import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iwish_flutter/global_controller/date_range_picker_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerBottomSheet extends StatelessWidget {
  final Function(dynamic) onConfirm;
  final Rx<DateTime?> initialSelectedDate;
  final Rx<PickerDateRange?> initialSelectedRange;
  final DateRangePickerSelectionMode mode;
  final DateRangePickerController controller = DateRangePickerController();
  final DateTime? minDate;

  DatePickerBottomSheet({
    super.key,
    required this.onConfirm,
    required this.mode,
    required this.initialSelectedDate,
    required this.initialSelectedRange,
    this.minDate,
  });

  @override
  Widget build(BuildContext context) {
    final dateController = Get.put(CustomDateRangePickerController());
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 40.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _headeerWidget(dateController),
          SizedBox(
            height: 24.h,
          ),
          Container(
            height: 1.h,
            color: ThemeColors().greyDivider,
          ),
          SizedBox(
            height: 24.h,
          ),
          Obx(
            () => SfDateRangePicker(
              controller: controller,
              minDate: minDate,
              onViewChanged: dateController.onViewChanged,
              selectionMode: mode,
              initialSelectedRange: initialSelectedRange.value,
              initialSelectedDate: initialSelectedDate.value,
              view: DateRangePickerView.month,
              backgroundColor: ThemeColors().transparent,
              showNavigationArrow: false,
              allowViewNavigation: true,
              headerHeight: 0,
              selectionShape: DateRangePickerSelectionShape.rectangle,
              selectionTextStyle: GoogleFonts.poppins(
                color: ThemeColors().eerieBlack,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              selectionColor: ThemeColors().secondaryColorTwo,
              startRangeSelectionColor: ThemeColors().secondaryColorTwo,
              endRangeSelectionColor: ThemeColors().secondaryColorTwo,
              rangeSelectionColor: ThemeColors().secondaryColorTwo,
              todayHighlightColor: ThemeColors().veryLightBlue,
              rangeTextStyle: GoogleFonts.poppins(
                color: ThemeColors().eerieBlack,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                weekendDays: const [7, 6],
                dayFormat: 'EEE',
                firstDayOfWeek: 1,
                showTrailingAndLeadingDates: true,
                enableSwipeSelection: false,
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ThemeColors().philippineGray,
                  ),
                ),
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                todayTextStyle: GoogleFonts.poppins(
                  color: ThemeColors().eerieBlack,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 32.h,
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: PrimaryButton(
              titleText: AppLocalizations.of(context)!.done,
              onPressed: () {
                if (mode == DateRangePickerSelectionMode.range) {
                  print(controller.selectedRange);
                  onConfirm(controller.selectedRange);
                } else if (mode == DateRangePickerSelectionMode.single) {
                  onConfirm(controller.selectedDate);
                }
              },
              backgroundColor: ThemeColors().secondaryColorTwo,
              foregroundColor: ThemeColors().black,
              textSize: 13.sp,
              fontWeight: FontWeight.w500,
              buttonRadius: 8.sp,
              width: 78.w,
              height: 41.h,
              borderSide: BorderSide(
                color: ThemeColors().secondaryColorOne,
                width: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headeerWidget(CustomDateRangePickerController dateController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            controller.backward!();
          },
          child: Container(
            padding: EdgeInsets.all(9.sp),
            decoration: BoxDecoration(
                color: ThemeColors().white,
                borderRadius: BorderRadius.circular(10.sp),
                border: Border.all(
                  color: ThemeColors().greyBorder,
                  width: 1,
                )),
            child: Image.asset(
              AppAssets.icArrowLeftGrey,
              width: 16.w,
              height: 16.h,
            ),
          ),
        ),
        Obx(
          () => TextWidget(
            text: dateController.headerString.value,
            color: ThemeColors().black,
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.forward!();
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(9.sp),
            decoration: BoxDecoration(
              color: ThemeColors().white,
              borderRadius: BorderRadius.circular(10.sp),
              border: Border.all(
                color: ThemeColors().greyBorder,
                width: 1,
              ),
            ),
            child: Image.asset(
              AppAssets.icArrowRightGrey,
              width: 16.w,
              height: 16.h,
            ),
          ),
        ),
      ],
    );
  }
}
