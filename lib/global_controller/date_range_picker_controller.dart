import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDateRangePickerController extends GetxController {
  RxString headerString = "".obs;

  void onViewChanged(DateRangePickerViewChangedArgs args) {
    final DateTime visibleStartDate = args.visibleDateRange.startDate!;
    final DateTime visibleEndDate = args.visibleDateRange.endDate!;
    final int totalVisibleDays =
        (visibleEndDate.difference(visibleStartDate).inDays);
    final DateTime midDate =
        visibleStartDate.add(Duration(days: totalVisibleDays ~/ 2));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      headerString.value = DateFormat('MMMM yyyy').format(midDate).toString();
    });
  }

  @override
  void onClose() {
    print("OncloseCALLED");
    super.onClose();
  }
}
