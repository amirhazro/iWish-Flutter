import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/modules/offers/controller/offers_controller.dart';
import 'package:iwish_flutter/modules/offers/models/offers_response_model.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:iwish_flutter/widgets/delete_wish_bottom_sheet.dart';
import 'package:iwish_flutter/widgets/image_widget.dart';
import 'package:iwish_flutter/widgets/loading_indicator.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:iwish_flutter/widgets/trip_to_from_widget.dart';

class OffersScreen extends StatelessWidget {
  static const String id = '/offersScreen';
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<OffersController>();
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          backgroundColor: ThemeColors().white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: Obx(
              () => CustomSecondaryAppBar(
                title:
                    '${AppLocalizations.of(context)!.wish} ${controller.titleWishNumber.value}',
                onBackPressed: () {
                  Get.back();
                },
                isDeleteWishButtonRequired: true,
                onDeletePressed: () {
                  CustomBottomSheet.showCustomBottomSheet(
                    context,
                    DeleteWishBottomSheet(
                      onCancelPressed: () {
                        Get.back();
                      },
                      onYesPleasePressed: () {
                        Get.back();
                        controller
                            .requestDeleteWish(Get.arguments['itemId'] ?? 0);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: AppLocalizations.of(context)!.offers,
                  color: ThemeColors().homeTopCardTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Expanded(
                  child: PagedListView(
                    pagingController: controller.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Offers>(
                      itemBuilder: (context, item, index) {
                        return _offersListItem(
                            context, item, index, controller);
                      },
                      firstPageProgressIndicatorBuilder: (context) =>
                          const LoadingIndicator(),
                      newPageProgressIndicatorBuilder: (context) =>
                          const LoadingIndicator(),
                      noItemsFoundIndicatorBuilder: (context) => Center(
                        child: TextWidget(
                          text: "No offers available",
                          color: ThemeColors().homeTopCardTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _offersListItem(BuildContext context, Offers item, int index,
      OffersController controller) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: ThemeColors().culturedTwo,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ImageWidget(
                imagePath: item.traveler?.picture ?? '',
                width: 30.w,
                height: 30.h,
                fit: BoxFit.cover,
                borderRadius: 6.sp,
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextWidget(
                          text:
                              '${item.traveler?.firstName ?? ''} ${item.traveler?.lastName ?? ''}',
                          color: ThemeColors().homeTopCardTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Image.asset(
                          AppAssets.icVarifiedProfilePic,
                          width: 13.w,
                          height: 13.h,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppAssets.icRating,
                          width: 12.w,
                          height: 12.h,
                        ),
                        SizedBox(
                          width: 6.sp,
                        ),
                        TextWidget(
                          text: '${item.traveler?.userRating ?? 0}',
                          color: ThemeColors().homeTopCardTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                decoration: BoxDecoration(
                    color: ThemeColors().white,
                    borderRadius: BorderRadius.circular(12.sp)),
                child: Row(
                  children: [
                    TextWidget(
                      text: (item.totalPrice ?? 0).toString(),
                      color: ThemeColors().homeTopCardTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    TextWidget(
                      text: item.currencyCode ?? 'USD',
                      color: ThemeColors().homeTopCardTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          ToFromWidget(
              toCity: item.trip?.toCity?.name ?? '',
              fromCity: item.trip?.fromCity?.name ?? '',
              toCountry: item.trip?.toCity?.countriesMaster?.iso3 ?? '',
              fromCountry: item.trip?.fromCity?.countriesMaster?.iso3 ?? '',
              date: item.trip?.departureDate ?? DateTime.now().toString()),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  titleText: AppLocalizations.of(context)!.acceptOffer,
                  onPressed: () {
                    controller.showOfferConfirmationBottomSheet(
                        context, item, index);
                  },
                  backgroundColor: ThemeColors().primaryColorOne,
                  foregroundColor: ThemeColors().black,
                  textSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  buttonRadius: Constant.buttonRadius.sp,
                  width: Get.width,
                  height: 34.h,
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes().getChatScreen(), arguments: {
                    'toUserId': item.offeredBy,
                    'fromUserId': item.offeredTo,
                    'userName':
                        '${item.traveler?.firstName ?? ''} ${item.traveler?.lastName ?? ''}',
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(6.sp),
                  width: 74.w,
                  height: 34.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Constant.buttonRadius.sp,
                    ),
                    color: ThemeColors().secondaryColorTwo,
                  ),
                  child: Image.asset(
                    AppAssets.icChatWhiteFilled,
                    width: 15.w,
                    height: 15.h,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
