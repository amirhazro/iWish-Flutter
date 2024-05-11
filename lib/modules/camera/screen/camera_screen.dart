import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/camera/controller/camera_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraView extends StatelessWidget {
  static const id = '/CameraView';
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CameraViewController>(
        init: CameraViewController(),
        builder: (controller) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: Get.width,
                height: Get.height,
                child: CameraPreview(
                  controller.cameraController,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Obx(() => CustomSecondaryAppBar(
                      title: controller.title.value,
                      onBackPressed: () {
                        Get.back();
                      },
                      isTransparentButton: true,
                    )),
              ),
              Image.asset(
                AppAssets.icCameraFrame,
                width: 302.w,
                height: 205.h,
              ),
              Positioned(
                top: 150.h,
                child: TextWidget(
                  text: AppLocalizations.of(context)!.cameraText,
                  color: ThemeColors().lightGray,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: GestureDetector(
                  onTap: controller.moveToNextImage,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    width: Get.width,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: ThemeColors().primaryColorOne,
                      borderRadius: BorderRadius.circular(
                        8.sp,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Image.asset(
                            AppAssets.icScan,
                            width: 16.w,
                            height: 16.h,
                          ),
                        ),
                        Obx(() => TextWidget(
                              text: controller.title.value,
                              color: ThemeColors().black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
