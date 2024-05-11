import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/global_controller/global_controller.dart';
import 'package:iwish_flutter/global_controller/social_controller.dart';
import 'package:iwish_flutter/modules/more_settings/controller/more_controller.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/widgets/image_widget.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class MoreScreen extends StatelessWidget {
  static const id = '/MoreScreen';
  final controller = Get.put(MoreController());
  MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 50.h,
          left: 16.w,
          right: 16.w,
          bottom: 16.h,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Obx(
                  () => ImageWidget(
                    imagePath: Get.find<GlobalController>().imagePath.value,
                    width: 41.w,
                    height: 41.h,
                    fit: BoxFit.cover,
                    borderRadius: 10.sp,
                    placeHolderImage: AppAssets.icPlaceHolderSmall,
                  ),
                ),
                SizedBox(
                  width: 24.w,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => TextWidget(
                          text:
                              'Hello${Get.find<GlobalController>().userName.value}, ',
                          color: ThemeColors().black,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.sp,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    TextWidget(
                      text: 'Good Morning',
                      color: ThemeColors().black,
                      fontWeight: FontWeight.w600,
                      fontSize: 17.sp,
                    ),
                  ],
                )),
                SizedBox(
                  width: 12.w,
                ),
                GestureDetector(
                  onTap: () async {
                    await StorageService().clearData();
                    Get.find<SocialsController>().signOutFromGoogle();
                    Get.offAllNamed(Routes().getSplashPage());
                  },
                  child: Image.asset(
                    AppAssets.icLogout,
                    width: 36.w,
                    height: 36.h,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            _moreContainer(
                () {}, 'Settings', 'Check and manage your account details'),
            Container(
              height: 1.5,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              color: ThemeColors().antiFlashWhite,
            ),
            _moreContainer(() {}, 'Invite Friends',
                'Earn and share cash with your friends'),
            Container(
              height: 1.5,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              color: ThemeColors().antiFlashWhite,
            ),
            _moreContainer(
                () {}, 'Transactions', 'Check your financial dashboard'),
            Container(
              height: 1.5,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              color: ThemeColors().antiFlashWhite,
            ),
            _moreContainer(
                () {}, 'Help & Support', 'Help center and legal terms'),
            Container(
              height: 1.5,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              color: ThemeColors().antiFlashWhite,
            ),
            _moreContainer(() {}, 'Submit a Request',
                'Get in touch with our team for help'),
            Container(
              height: 1.5,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              color: ThemeColors().antiFlashWhite,
            ),
            _moreContainer(() {}, 'Rate Our App', 'We`d like to hear from you'),
            Container(
              height: 1.5,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              color: ThemeColors().antiFlashWhite,
            ),
            _moreContainer(() {}, 'Privacy Policy', 'Our privacy and policies'),
          ],
        ),
      ),
    );
  }

  Widget _moreContainer(VoidCallback onTap, String title, String detail) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: title,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: ThemeColors().black,
            ),
            TextWidget(
              text: detail,
              fontWeight: FontWeight.w300,
              fontSize: 13.sp,
              color: ThemeColors().black,
            )
          ],
        )),
        Image.asset(
          AppAssets.icArrowRight,
          color: ThemeColors().black,
          width: 16.w,
          height: 16.h,
        )
      ],
    );
  }
}
