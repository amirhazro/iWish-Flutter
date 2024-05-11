import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/create_a_wish/controller/product_detail_controller.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

import '../../../utils/routes.dart';

class SelectAddress extends StatelessWidget {
  static const id = '/SelectAddressScreen';
  SelectAddress({super.key});

  final controller = Get.find<ProductDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors().white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: CustomSecondaryAppBar(
          title: '',
          onBackPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  TextWidget(
                    text: AppLocalizations.of(context)!.myAddress,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors().black,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextWidget(
                    text: AppLocalizations.of(context)!.addAddressDetail,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: ThemeColors().greyAddress,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: controller.lstAddresses.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.addressId.value =
                                  controller.lstAddresses[index].id;
                              Get.toNamed(Routes().getProductSummaryScreen());
                            },
                            child: Obx(
                              () => Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                padding: EdgeInsets.all(12.sp),
                                decoration: controller.addressId.value ==
                                        controller.lstAddresses[index].id
                                    ? BoxDecoration(
                                        color: ThemeColors()
                                            .toggleSwitchBackgroundColorActive
                                            .withOpacity(0.26),
                                        borderRadius: BorderRadius.circular(
                                          8.sp,
                                        ),
                                      )
                                    : BoxDecoration(
                                        color: ThemeColors()
                                            .addressSelectionScreenBackground,
                                        borderRadius: BorderRadius.circular(
                                          8.sp,
                                        ),
                                      ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible: controller
                                              .lstAddresses[index].set_as ==
                                          "primary",
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 10.sp),
                                        decoration: BoxDecoration(
                                            color: ThemeColors()
                                                .toggleSwitchBackgroundColorActive
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8.sp)),
                                        padding: EdgeInsets.all(8.sp),
                                        child: TextWidget(
                                          text: AppLocalizations.of(context)!
                                              .primaryAddress,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ThemeColors().purpleLight,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          controller.lstAddresses[index]
                                                      .set_as ==
                                                  "primary"
                                              ? AppAssets.icAddressHome
                                              : AppAssets.icAddressOther,
                                          width: 40.w,
                                          height: 40.h,
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                text: controller
                                                    .lstAddresses[index]
                                                    .address_name,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: ThemeColors()
                                                    .blackVersionTwo,
                                              ),
                                              TextWidget(
                                                text:
                                                    '${controller.lstAddresses[index].street_address}, ${controller.lstAddresses[index].city},  ${controller.lstAddresses[index].state}, ${controller.lstAddresses[index].zip_code}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ThemeColors().greyAddress,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  )
                ],
              ),
            ),
            PrimaryButton(
              titleText: AppLocalizations.of(context)!.addNewAddress,
              onPressed: controller.navToAddAddressScreen,
              backgroundColor: ThemeColors().primaryColorOne,
              foregroundColor: ThemeColors().black,
              textSize: 14.sp,
              fontWeight: FontWeight.w500,
              buttonRadius: Constant.buttonRadius.sp,
              width: Get.width,
              height: 50.h,
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
}
