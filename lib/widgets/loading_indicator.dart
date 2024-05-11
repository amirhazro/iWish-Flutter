import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwish_flutter/utils/colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100.h.sp,
        height: 100.h.sp,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        // child: Image.asset(
        //   AppAssets.icIwishLogo,
        //   height: 60,
        //   width: 60,
        //   fit: BoxFit.cover,
        // ),
        child: CircularProgressIndicator(
          color: ThemeColors().primaryColorOne,
        ),
      ),
    );
  }
}
