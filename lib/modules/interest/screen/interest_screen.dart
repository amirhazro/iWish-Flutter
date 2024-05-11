import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/modules/interest/controller/interest_controller.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/widgets/image_widget.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class InterestScreen extends StatelessWidget {
  static const id = "/InterestScreen";
  InterestScreen({super.key});

  final InterestController _controller = Get.find<InterestController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: _controller.isLoading.value,
        child: Scaffold(
          backgroundColor: ThemeColors().white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(95.h),
            child: Container(
              margin: EdgeInsets.only(
                top: 75.h,
                left: 40.w,
                right: 40.w,
              ),
              child: TextWidget(
                text: AppLocalizations.of(context)!.selectInterestHeading,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: ThemeColors().black,
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 12.w,
            ),
            padding: EdgeInsets.only(top: 50.h),
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Wrap(
                        direction: Axis.horizontal,
                        spacing: 16.h,
                        runSpacing: 16.h,
                        children: _controller.lstInterestData.map((element) {
                          return GestureDetector(
                            onTap: () => _controller.handleSelection(element),
                            child: Obx(
                              () => chip(
                                context,
                                element.iconPath,
                                element.title,
                                element.isSelected.value,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: PrimaryButton(
                    titleText: AppLocalizations.of(context)!.confirm,
                    onPressed: _controller.requestPostUserInterest,
                    backgroundColor: ThemeColors().primaryColorOne,
                    foregroundColor: ThemeColors().black,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    buttonRadius: Constant.buttonRadius.sp,
                    width: Get.width,
                    height: 50.h,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chip(context, itemImage, itemName, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.sp),
      decoration: BoxDecoration(
        color: isSelected
            ? ThemeColors().secondaryColorTwo
            : ThemeColors().greySocialButtons,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidget(
            imagePath: itemImage,
            fit: BoxFit.cover,
            width: 30.w,
            height: 30.h,
            borderRadius: 8.sp,
          ),
          SizedBox(
            width: 8.w,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 220.w),
            child: TextWidget(
              text: itemName,
              fontSize: 15.sp,
              fontWeight: FontWeight.w300,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              color: ThemeColors().black,
            ),
          ),
        ],
      ),
    );
  }
}
