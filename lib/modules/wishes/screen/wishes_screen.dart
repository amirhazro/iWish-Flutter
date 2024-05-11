import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/modules/wishes/controller/wishes_controller.dart';
import 'package:iwish_flutter/modules/wishes/models/wishes_response_model.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/utils/custom_popup.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/delete_wish_bottom_sheet.dart';
import 'package:iwish_flutter/widgets/image_widget.dart';
import 'package:iwish_flutter/widgets/loading_indicator.dart';
import 'package:iwish_flutter/widgets/new_wish_bottom_sheet_widget.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/review_bottom_sheet.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class WishesScreen extends StatelessWidget {
  static const id = "/WishesScreen";
  const WishesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WishesController>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ThemeColors().white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomSecondaryAppBar(
          title: AppLocalizations.of(context)!.wishes,
          onBackPressed: () {},
          isBackButtonRequired: false,
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              CustomBottomSheet.showCustomBottomSheet(
                  context,
                  NewWishBottomSheetContent(
                    onCreateNewWishPressed: () async {
                      Get.back();
                      bool isVerified =
                          await StorageService().readBool(Keys.UserIsVarified);
                      if (isVerified) {
                        Get.toNamed(Routes().getProductDetailScreen());
                      } else {
                        await Get.toNamed(Routes().getCompleteAccountScreen());

                        bool isVerifiedd = await StorageService()
                            .readBool(Keys.UserIsVarified);

                        if (isVerifiedd) {
                          Get.toNamed(
                            Routes().getProductDetailScreen(),
                          );
                        }
                      }
                    },
                    onTrendingWishesPressed: () {
                      Get.back();
                      Get.toNamed(Routes().getTrendingWishesScreen());
                    },
                    onInfoIconTapIstButton: () {
                      CustomPopup.showCustomDialog(
                          context,
                          "Create Wish Information",
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,");
                    },
                    onInfoIconTap2ndButton: () {
                      CustomPopup.showCustomDialog(
                          context,
                          "Trending Wishes Information",
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,");
                    },
                  ));
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12.sp,
                vertical: 8.sp,
              ),
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: ThemeColors().homeTopCardColorOne.withOpacity(0.10),
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Image.asset(
                      AppAssets.icStar,
                      width: 26.w,
                      height: 26.h,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextWidget(
                      text: AppLocalizations.of(context)!.makeAWish,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: ThemeColors().homeTopCardTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: controller.tabs.length,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    dividerColor: ThemeColors().antiFlashWhite,
                    tabAlignment: TabAlignment.start,
                    controller: controller.tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 1,
                        color: ThemeColors().black,
                      ),
                    ),
                    unselectedLabelColor:
                        ThemeColors().homeTopCardTextColor.withOpacity(0.5),
                    labelColor: ThemeColors().black,
                    indicatorColor: ThemeColors().black,
                    isScrollable: true,
                    tabs: controller.tabs,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: controller.tabs.map((Tab tab) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.sp),
                          child: _shopperListWidget(context, controller),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _shopperListWidget(BuildContext context, WishesController controller) {
    return PagedListView(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Wishes>(
        itemBuilder: (context, item, index) {
          return Container(
            margin: EdgeInsets.only(top: 16.h),
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: ThemeColors().cultured,
              borderRadius: BorderRadius.all(
                Radius.circular(10.sp),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ImageWidget(
                      width: 75.w,
                      height: 90.h,
                      borderRadius: 10.sp,
                      fit: BoxFit.cover,
                      imagePath: (item.userWishlistImages != null &&
                              item.userWishlistImages!.isNotEmpty
                          ? item.userWishlistImages!.first.fileName
                          : ''),
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
                                  text: item.productName ?? '',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeColors().black,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              if (item.deliveryStatus ==
                                  Constant.wishStatuses.first)
                                GestureDetector(
                                  onTap: () {
                                    controller.requestGetWisheDetail(
                                        item.id ?? 0, false, true);
                                  },
                                  child: SizedBox(
                                    width: 20.w,
                                    height: 20.h,
                                    child: Image.asset(
                                      AppAssets.icEdit,
                                      width: 16.w,
                                      height: 16.h,
                                    ),
                                  ),
                                )
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              TextWidget(
                                text: item.deliveryStatus ==
                                        Constant.wishStatuses.first
                                    ? 'Your Order is Getting Ready for '
                                    : ' ',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: ThemeColors().black,
                              ),
                              TextWidget(
                                text: item.deliveryStatus ==
                                        Constant.wishStatuses.first
                                    ? ' Shipping!'
                                    : '',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: ThemeColors().black,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () => controller.requestGetWisheDetail(
                                item.id ?? 0, true, false),
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
                          SizedBox(
                            height: 8.h,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                if (item.deliveryStatus == Constant.wishStatuses.first)
                  _viewAvailableOffersWidget(context, item, controller),
                if (item.deliveryStatus == 'processing' ||
                    item.deliveryStatus == 'shipped' ||
                    item.deliveryStatus == 'delivered' ||
                    item.deliveryStatus == 'completed')
                  _processingShippedDeliveredWidget(context, item, controller),
                if (item.deliveryStatus == 'inactive')
                  _inactiveCallToActions(context, controller, item)
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

  Row _inactiveCallToActions(
      BuildContext context, WishesController controller, Wishes item) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            titleText: AppLocalizations.of(context)!.delete,
            onPressed: () {
              CustomBottomSheet.showCustomBottomSheet(
                context,
                DeleteWishBottomSheet(
                  onCancelPressed: () {
                    Get.back();
                  },
                  onYesPleasePressed: () {
                    Get.back();
                    controller.requestDeleteWish(item.id ?? 0);
                  },
                ),
              );
            },
            backgroundColor: ThemeColors().transparent,
            foregroundColor: ThemeColors().sweetBrown,
            textSize: 12.sp,
            fontWeight: FontWeight.w400,
            buttonRadius: 4.sp,
            width: Get.width,
            height: 30.h,
            borderSide: BorderSide(
              color: ThemeColors().sweetBrown,
              width: 0.5,
            ),
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        Expanded(
          child: PrimaryButton(
            titleText: AppLocalizations.of(context)!.reWish,
            onPressed: () => controller.requestUpdateWishStatus(item.id ?? 0),
            backgroundColor: ThemeColors().secondaryColorTwo,
            foregroundColor: ThemeColors().black,
            textSize: 12.sp,
            fontWeight: FontWeight.w400,
            buttonRadius: 4.sp,
            width: Get.width,
            height: 30.h,
          ),
        )
      ],
    );
  }

  Widget _processingShippedDeliveredWidget(
      BuildContext context, Wishes item, WishesController controller) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w),
      child: Row(
        children: [
          ImageWidget(
            imagePath: item.user?.picture ?? '',
            width: 30.w,
            height: 30.h,
            fit: BoxFit.cover,
            borderRadius: 6.sp,
          ),
          SizedBox(
            width: 8.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                    text:
                        '${item.user?.firstName ?? ''} ${item.user?.lastName ?? ''}',
                    color: ThemeColors().homeTopCardTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 11.sp,
                  ),
                  SizedBox(
                    width: 4.sp,
                  ),
                  Image.asset(
                    AppAssets.icVerifyShield,
                    width: 13.w,
                    height: 13.h,
                  ),
                  SizedBox(
                    width: 4.sp,
                  ),
                  Image.asset(
                    AppAssets.icRedFlag,
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
                    text: '${item.user?.userRating ?? 0}',
                    color: ThemeColors().homeTopCardTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          if (item.deliveryStatus == 'delivered')
            PrimaryButton(
              titleText: AppLocalizations.of(context)!.confirmDelivery,
              onPressed: () => controller.requestUpdateWishStatus(item.id ?? 0,
                  status: 'completed'),
              backgroundColor: ThemeColors().primaryColorOne,
              foregroundColor: ThemeColors().black,
              textSize: 12.sp,
              fontWeight: FontWeight.w400,
              buttonRadius: 4.sp,
              width: 138.w,
              height: 30.h,
            ),
          if (item.deliveryStatus == 'completed')
            PrimaryButton(
              titleText: AppLocalizations.of(context)!.review,
              onPressed: () {
                if (item.reviewByWisher == "1") {
                  CustomPopup.showCustomDialog(
                      context,
                      "Duplicate Review Error",
                      "You've already submitted a review for this product. Your feedback matters, but we limit reviews to ensure fairness and accuracy. For additional feedback or queries, please contact our support team. Thank you for your cooperation!");
                  return;
                }
                CustomBottomSheet.showCustomBottomSheet(
                  context,
                  modalColor: ThemeColors().white,
                  ReviewBottomSheet(
                    titleOne: AppLocalizations.of(context)!.reviewShopper,
                    titleTwo: AppLocalizations.of(context)!.reviewProduct,
                    textControllerOne: TextEditingController(),
                    textControllerTwo: TextEditingController(),
                    onCancelPressed: () {
                      Get.back();
                    },
                    onYesPleasePressed: () {
                      if (controller.ratingProduct == null ||
                          controller.ratingShopper == null) {
                        CustomPopup.showCustomDialog(
                            context,
                            "Information Missing",
                            "Please provide rating for both shopper and product");
                        return;
                      }
                      Get.back();
                      controller.requestReviewTraveler(item.id ?? 0,
                          item.offers?.first.offeredBy ?? 0, context);
                    },
                    onRatingChangeOne: (value) {
                      controller.ratingShopper = value;
                      Utils.dismissKeyboard(context);
                    },
                    onRatingChangeTwo: (value) {
                      controller.ratingProduct = value;
                      Utils.dismissKeyboard(context);
                    },
                  ),
                );
              },
              backgroundColor: ThemeColors().peachOrange,
              foregroundColor: ThemeColors().black,
              textSize: 12.sp,
              fontWeight: FontWeight.w400,
              buttonRadius: 4.sp,
              width: 138.w,
              height: 30.h,
            ),
        ],
      ),
    );
  }

  Widget _viewAvailableOffersWidget(
      BuildContext context, Wishes item, WishesController controller) {
    return GestureDetector(
      onTap: () async {
        var res = await Get.toNamed(Routes().getOffersScreen(),
            arguments: {'itemId': item.id});
        if (res) {
          controller.pagingController.itemList?.clear();
          controller.requestGetWishesList(1);
        }
      },
      child: Container(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.sp),
            border: Border.all(
              color: ThemeColors().lavenderBlue,
            )),
        child: Row(
          children: [
            Expanded(
              child: TextWidget(
                text: AppLocalizations.of(context)!.viewAvailableOffers,
                color: ThemeColors().black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextWidget(
              text: '${item.offersCount ?? '0'}',
              color: ThemeColors().black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              width: 8.w,
            ),
            Image.asset(
              AppAssets.icArrowRight,
              width: 16.w,
              height: 16.h,
              color: ThemeColors().toggleSwitchBackgroundColorActive,
            )
          ],
        ),
      ),
    );
  }
}
