import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/modules/trips/controller/trip_detail_controller.dart';
import 'package:iwish_flutter/modules/trips/models/offers_response_model.dart';
import 'package:iwish_flutter/modules/trips/models/trip_detail_response_model.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/utils/custom_popup.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:iwish_flutter/widgets/image_widget.dart';
import 'package:iwish_flutter/widgets/loading_indicator.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/make_offer_bottom_sheet.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/review_bottom_sheet.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:iwish_flutter/widgets/trip_to_from_widget.dart';

class TripDetailScreen extends StatelessWidget {
  static const id = '/TripDetailScreen';
  final controller = Get.find<TripDetailController>();
  TripDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: ThemeColors().white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: CustomSecondaryAppBar(
                title: AppLocalizations.of(context)!.tripDetails,
                onBackPressed: () {
                  Get.back();
                },
                isBackButtonRequired: true,
              ),
            ),
            body: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                      vertical: 8.sp,
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                        color: ThemeColors().white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.sp),
                        ),
                        border: Border.all(color: ThemeColors().greyBorder)),
                    child: ToFromWidget(
                      toCity: controller.toCityNameDetail.value ?? '',
                      fromCity: controller.fromCityNameDetail.value ?? '',
                      toCountry: controller.toCountryNameDetail.value ?? '',
                      fromCountry: controller.fromCountryNameDetail.value ?? '',
                      date: controller.dateOfTrip.value ??
                          DateTime.now().toString(),
                    ),
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: controller.tabs.length,
                    child: Column(
                      children: [
                        TabBar(
                          tabAlignment: TabAlignment.start,
                          dividerColor: ThemeColors().antiFlashWhite,
                          controller: controller.tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: true,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 1,
                              color: ThemeColors().black,
                            ),
                          ),
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          unselectedLabelColor: ThemeColors()
                              .homeTopCardTextColor
                              .withOpacity(0.5),
                          labelColor: ThemeColors().black,
                          indicatorColor: ThemeColors().black,
                          tabs: controller.tabs,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            // children: controller.tabs.map((Tab tab) {

                            //   return Padding(
                            //     padding:
                            //         EdgeInsets.symmetric(horizontal: 16.sp),
                            //     child: _shopperListWidget(context, controller),
                            //   );
                            // }).toList(),
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.sp),
                                  child:
                                      _shopperListWidget(context, controller)),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.sp),
                                child: _offerListWidget(context, controller),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.sp),
                                child: _offerListWidget(context, controller),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.sp),
                                child: _offerListWidget(context, controller),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.sp),
                                child: const Center(
                                  child: Text('Disputed'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _shopperListWidget(
      BuildContext context, TripDetailController controller) {
    return PagedListView(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Wishes>(
        itemBuilder: (context, item, index) {
          return Container(
            margin: EdgeInsets.only(top: 16.h),
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: ThemeColors().culturedTwo,
              borderRadius: BorderRadius.all(
                Radius.circular(10.sp),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ImageWidget(
                      width: 72.w,
                      height: 81.h,
                      borderRadius: 10.sp,
                      fit: BoxFit.cover,
                      imagePath: item.userWishlistImages?.first.fileName,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextWidget(
                                  text: '${item.productName}',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeColors().black,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 16.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                  color: ThemeColors().white,
                                  borderRadius: BorderRadius.circular(12.sp)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    text:
                                        AppLocalizations.of(context)!.viewOrder,
                                    color: ThemeColors().spanishGray,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  Image.asset(
                                    AppAssets.icArrowRightBlue,
                                    width: 16.w,
                                    height: 16.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Get.toNamed(
                          //     Routes().getBankAccountVerificationScreen());
                          controller.selectedWishIndex = index;
                          CustomBottomSheet.showCustomBottomSheet(
                            context,
                            MakeOfferBottomSheet(
                              controller: controller,
                              onProceed:
                                  controller.moveToOfferConfirmationSheet,
                              onCrossPressed: () {
                                Get.back();

                                controller.clearData();
                              },
                            ),
                            constraints: BoxConstraints(
                              maxHeight: Get.height * 0.9,
                            ),
                            enableDrag: false,
                          );
                        },
                        child: Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                              color: ThemeColors().primaryColorOne,
                              borderRadius: BorderRadius.circular(12.sp)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: AppLocalizations.of(context)!.makeAnOffer,
                                color: ThemeColors().black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              Image.asset(
                                AppAssets.icArrowRight,
                                width: 16.w,
                                height: 16.h,
                                color: ThemeColors().homeTopCardTextColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        visible: controller.selectedTabIndex.value != 0,
                        child: SizedBox(width: 8.w),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        visible: controller.selectedTabIndex.value != 0,
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
                          child: Image.asset(AppAssets.icChatWhiteFilled),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (context) =>
            const LoadingIndicator(),
        newPageProgressIndicatorBuilder: (context) => const LoadingIndicator(),
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: TextWidget(
            text: "No wishes found for this trip",
            color: ThemeColors().homeTopCardTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _offerListWidget(
      BuildContext context, TripDetailController controller) {
    return PagedListView(
      pagingController: controller.pagingOfferController,
      builderDelegate: PagedChildBuilderDelegate<Offers>(
        itemBuilder: (context, item, index) {
          return Container(
            margin: EdgeInsets.only(top: 16.h),
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: ThemeColors().culturedTwo,
              borderRadius: BorderRadius.all(
                Radius.circular(10.sp),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ImageWidget(
                      width: 72.w,
                      height: 81.h,
                      borderRadius: 10.sp,
                      fit: BoxFit.cover,
                      imagePath: item.userWishlist?.userWishlistImages?.first
                              .fileName ??
                          '',
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextWidget(
                                  text: item.userWishlist?.productName ?? '',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeColors().black,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 16.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                  color: ThemeColors().white,
                                  borderRadius: BorderRadius.circular(12.sp)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    text:
                                        AppLocalizations.of(context)!.viewOrder,
                                    color: ThemeColors().spanishGray,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  Image.asset(
                                    AppAssets.icArrowRightBlue,
                                    width: 16.w,
                                    height: 16.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: editWishOrStatus(
                          item.offerStatus?.toLowerCase() == "pending",
                          context,
                          controller,
                          index,
                          item),
                    ),
                    Obx(
                      () => Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        visible: controller.selectedTabIndex.value != 0,
                        child: SizedBox(width: 8.w),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        visible: controller.selectedTabIndex.value != 0,
                        child: Container(
                          padding: EdgeInsets.all(6.sp),
                          width: 74.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Constant.buttonRadius.sp,
                            ),
                            color: ThemeColors().secondaryColorTwo,
                          ),
                          child: Image.asset(AppAssets.icChatWhiteFilled),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (context) =>
            const LoadingIndicator(),
        newPageProgressIndicatorBuilder: (context) => const LoadingIndicator(),
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: TextWidget(
            text: "No wishes found",
            color: ThemeColors().homeTopCardTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  editWishOrStatus(bool isEdit, BuildContext context,
      TripDetailController controller, int index, Offers item) {
    if (isEdit) {
      return GestureDetector(
        onTap: () {
          controller.isUpdate.value = true;
          controller.selectedWishIndex = index;
          controller.expiaryTextController.text = '${item.expiry ?? 0}';
          controller.purchasedFromTextController.text = item.purchaseFrom ?? '';
          controller.productPriceTextController.text =
              '${item.productPrice ?? 0}';
          controller.myFeesTextController.text = '${item.travelerFee ?? 0}';
          controller.currency.value = controller.lstCurrenciesData
              .where((p0) => p0.currencyName == item.currencyCode)
              .first;

          CustomBottomSheet.showCustomBottomSheet(
            context,
            MakeOfferBottomSheet(
              controller: controller,
              onProceed: controller.moveToOfferConfirmationSheet,
              onCrossPressed: () {
                Get.back();
                controller.clearData();
              },
            ),
            constraints: BoxConstraints(
              maxHeight: Get.height * 0.9,
            ),
            enableDrag: false,
          );
        },
        child: Container(
          height: 36.h,
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
          ),
          decoration: BoxDecoration(
              color: ThemeColors().primaryColorOne,
              borderRadius: BorderRadius.circular(8.sp)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: AppLocalizations.of(context)!.editOffer,
                color: ThemeColors().black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: '${item.totalPrice ?? ''}',
                    color: ThemeColors().homeTopCardTextColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  TextWidget(
                    text: item.currencyCode ?? '',
                    color: ThemeColors().homeTopCardTextColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    } else if (item.userWishlist?.deliveryStatus?.toLowerCase() ==
        'processing') {
      return GestureDetector(
        onTap: () => controller.requestUpdateWishStatus(
            'delivered', item.userWishlist?.id ?? 0),
        child: Container(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
              color: ThemeColors().secondaryColorTwo,
              borderRadius: BorderRadius.circular(12.sp)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: AppLocalizations.of(context)!.setAsDelivered,
                color: ThemeColors().black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              Row(
                children: [
                  TextWidget(
                    text: '${item.totalPrice ?? ''}',
                    color: ThemeColors().black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  TextWidget(
                    text: item.currencyCode ?? '',
                    color: ThemeColors().black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    } else if (item.userWishlist?.deliveryStatus?.toLowerCase() ==
            'delivered' ||
        item.userWishlist?.deliveryStatus?.toLowerCase() == 'completed') {
      return PrimaryButton(
          titleText: AppLocalizations.of(context)!.reviewWisher,
          onPressed: () {
            if (item.userWishlist?.deliveryStatus?.toLowerCase() ==
                'delivered') {
              return;
            } else if (item.userWishlist?.reviewByTraveler == "1") {
              CustomPopup.showCustomDialog(context, "Duplicate Review Error",
                  "You've already submitted a review for this product. Your feedback matters, but we limit reviews to ensure fairness and accuracy. For additional feedback or queries, please contact our support team. Thank you for your cooperation!");
              return;
            }

            CustomBottomSheet.showCustomBottomSheet(
              context,
              modalColor: ThemeColors().white,
              ReviewBottomSheet(
                titleOne: AppLocalizations.of(context)!.reviewWisherSmallW,
                titleTwo: AppLocalizations.of(context)!.reviewIwish,
                textControllerOne: TextEditingController(),
                textControllerTwo: TextEditingController(),
                onCancelPressed: () {
                  Get.back();
                },
                onYesPleasePressed: () {
                  if (controller.ratingIwish == null ||
                      controller.ratingShopper == null) {
                    CustomPopup.showCustomDialog(context, "Information Missing",
                        "Please provide rating for both shopper and product");
                    return;
                  }
                  Get.back();
                  controller.requestReviewWisher(
                      item.userWishlist?.id ?? 0,
                      item.offeredTo ?? 0,
                      item.tripId ?? 0,
                      item.id ?? 0,
                      context);
                },
                onRatingChangeOne: (value) {
                  controller.ratingShopper = value;
                  Utils.dismissKeyboard(context);
                },
                onRatingChangeTwo: (value) {
                  controller.ratingIwish = value;
                  Utils.dismissKeyboard(context);
                },
              ),
            );
          },
          backgroundColor: ThemeColors().primaryColorOne,
          foregroundColor: ThemeColors().black,
          textSize: 12.sp,
          fontWeight: FontWeight.w400,
          buttonRadius: 8.sp,
          width: Get.width,
          height: 36.h);

      // return Container(
      //   padding:
      //       EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
      //   decoration: BoxDecoration(
      //       color: ThemeColors().secondaryColorTwo,
      //       borderRadius: BorderRadius.circular(12.sp)),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       TextWidget(
      //         text: AppLocalizations.of(context)!.reviewWisher,
      //         color: ThemeColors().black,
      //         fontSize: 12.sp,
      //         fontWeight: FontWeight.w400,
      //       ),
      //       Row(
      //         children: [
      //           TextWidget(
      //             text: '${item.totalPrice ?? ''}',
      //             color: ThemeColors().black,
      //             fontSize: 12.sp,
      //             fontWeight: FontWeight.w400,
      //           ),
      //           SizedBox(
      //             width: 4.w,
      //           ),
      //           TextWidget(
      //             text: item.currencyCode ?? '',
      //             color: ThemeColors().black,
      //             fontSize: 12.sp,
      //             fontWeight: FontWeight.w400,
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // );
    } else {
      return Container(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
            color: ThemeColors().secondaryColorTwo,
            borderRadius: BorderRadius.circular(12.sp)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: AppLocalizations.of(context)!.rejected,
              color: ThemeColors().black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            Row(
              children: [
                TextWidget(
                  text: '${item.totalPrice ?? ''}',
                  color: ThemeColors().black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  width: 4.w,
                ),
                TextWidget(
                  text: item.currencyCode ?? '',
                  color: ThemeColors().black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            )
          ],
        ),
      );
    }
  }
}
