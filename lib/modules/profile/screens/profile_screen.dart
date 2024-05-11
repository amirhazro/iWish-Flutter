import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/profile/controller/profile_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/image_widget.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  static const id = '/ProfileScreen';
  var controller = Get.find<ProfileController>();
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
            backgroundColor: ThemeColors().white,
            body: Stack(
              children: [
                SizedBox(
                  height: 120.h,
                  child: Stack(
                    children: [
                      Image.asset(
                        AppAssets.icProfileCover,
                        width: Get.width,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 16.w, right: 16.w),
                            width: 35.w,
                            height: 35.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(
                              10.sp,
                            ),
                            decoration: BoxDecoration(
                                color: ThemeColors().transparent,
                                borderRadius: BorderRadius.circular(10.sp),
                                border: Border.all(
                                  color: ThemeColors().greyBorder,
                                  width: 1,
                                )),
                            child: Image.asset(
                              Get.locale!.languageCode == 'en'
                                  ? AppAssets.icBackArrow
                                  : AppAssets.icBackArrowAr,
                              width: 16.w,
                              height: 16.h,
                              color: ThemeColors().white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Container(
                          margin: EdgeInsets.only(left: 16.w, right: 16.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AppAssets.icReportProfile,
                                width: 35.w,
                                height: 35.h,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Image.asset(
                                AppAssets.icBlockProfile,
                                width: 35.w,
                                height: 35.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 60.h),
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                            color: ThemeColors().white,
                            borderRadius: BorderRadius.circular(14.sp)),
                        child: Obx(
                          () => ImageWidget(
                            imagePath: controller.profilePicture.value,
                            width: 95.w,
                            height: 95.h,
                            fit: BoxFit.cover,
                            borderRadius: 12.sp,
                          ),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0, -20.h, 0),
                        child: Image.asset(
                          AppAssets.icVarifiedWithBorderWhite,
                          width: 26,
                          height: 31.h,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
