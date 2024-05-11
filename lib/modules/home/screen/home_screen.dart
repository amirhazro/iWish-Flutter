import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/global_controller/global_controller.dart';
import 'package:iwish_flutter/modules/home/controller/home_controller.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/custom_popup.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/widgets/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/home_top_card.dart';
import 'package:iwish_flutter/widgets/new_wish_bottom_sheet_widget.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/rewish_wish_bottom_sheet_widget.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class HomeScreen extends StatelessWidget {
  static const id = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: ThemeColors().white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.h),
        child: Obx(
          () => HomeAppBar(
            userName:
                '${AppLocalizations.of(context)!.hello}${Get.find<GlobalController>().userName.value}',
            imagePath: Get.find<GlobalController>().imagePath.value,
            onChatPressed: () {
              Get.toNamed(Routes().getChatListScreen());
            },
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: HomeTopCard(
                    title: AppLocalizations.of(context)!.makeAWish,
                    detail: AppLocalizations.of(context)!.getOffsoreProducts,
                    iconPath: AppAssets.icStar,
                    onPressed: () {
                      CustomBottomSheet.showCustomBottomSheet(
                          context,
                          NewWishBottomSheetContent(
                            onCreateNewWishPressed: () async {
                              Get.back();
                              bool isVerified = await StorageService()
                                  .readBool(Keys.UserIsVarified);
                              if (isVerified) {
                                Get.toNamed(Routes().getProductDetailScreen());
                              } else {
                                await Get.toNamed(
                                    Routes().getCompleteAccountScreen());

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
                    backgroundColor:
                        ThemeColors().homeTopCardColorOne.withOpacity(0.1),
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: HomeTopCard(
                    title: AppLocalizations.of(context)!.traveling,
                    detail: AppLocalizations.of(context)!.tripAndEarn,
                    iconPath: AppAssets.icFlight,
                    onPressed: () async {
                      bool isVerified =
                          await StorageService().readBool(Keys.UserIsVarified);
                      if (isVerified) {
                        Get.toNamed(
                          Routes().getAddTripScreen(),
                        );
                      } else {
                        await Get.toNamed(Routes().getCompleteAccountScreen(),
                            arguments: {'isTripFlow': true});

                        bool isVerifiedd = await StorageService()
                            .readBool(Keys.UserIsVarified);

                        if (isVerifiedd) {
                          Get.toNamed(
                            Routes().getAddTripScreen(),
                            arguments: {'isVerifiedFlow': true},
                          );
                        }
                      }
                    },
                    backgroundColor: ThemeColors()
                        .toggleSwitchBackgroundColorActive
                        .withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _topShoppers(context, controller),
                  SizedBox(
                    height: 40.h,
                  ),
                  _trendingWishes(context, controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topShoppers(BuildContext context, HomeController controller) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: AppLocalizations.of(context)!.topShoppers,
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: ThemeColors().homeTopCardTextColor,
              ),
              GestureDetector(
                onTap: () => Get.toNamed(
                  Routes().getShopperScreen(),
                ),
                child: Row(
                  children: [
                    TextWidget(
                      text: AppLocalizations.of(context)!.viewAll,
                      fontWeight: FontWeight.w300,
                      fontSize: 15.sp,
                      color: ThemeColors().homeTopCardTextColor,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Image.asset(
                      AppAssets.icArrowRight,
                      height: 12.h,
                      width: 12.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        SizedBox(
          height: 115.h,
          child: Obx(
            () => controller.isTopShoppersDataExist.value
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: controller.lstTopShoppersData.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Get.toNamed(Routes().getProfileScreen(),
                            arguments: {
                              'profileData':
                                  controller.lstTopShoppersData[index].toJson()
                            }),
                        child: Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                  10.sp,
                                ) // Adjust the radius as needed
                                    ),
                                child: controller.lstTopShoppersData[index]
                                                .picture !=
                                            null &&
                                        controller.lstTopShoppersData[index]
                                            .picture!.isNotEmpty
                                    ? CachedNetworkImage(
                                        width: 67.sp,
                                        height: 67.sp,
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            '${APIConfiguration.baseImage}${controller.lstTopShoppersData[index].picture}',
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          AppAssets.icProfilePlaceHolderImage,
                                        ),
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          AppAssets.icPlaceHolderSmall,
                                          width: 67.sp,
                                          height: 67.sp,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Image.asset(
                                        AppAssets.icPlaceHolderSmall,
                                        width: 67.sp,
                                        height: 67.sp,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              TextWidget(
                                text:
                                    '${controller.lstTopShoppersData[index].firstName}',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: ThemeColors().homeTopCardTextColor,
                              )
                            ],
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: Text("No Data available"),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _trendingWishes(BuildContext context, HomeController controller) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: AppLocalizations.of(context)!.trendingWishes,
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: ThemeColors().homeTopCardTextColor,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes().getTrendingWishesScreen());
                    },
                    child: TextWidget(
                      text: AppLocalizations.of(context)!.viewAll,
                      fontWeight: FontWeight.w300,
                      fontSize: 15.sp,
                      color: ThemeColors().homeTopCardTextColor,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Image.asset(
                    AppAssets.icArrowRight,
                    height: 12.h,
                    width: 12.w,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Obx(
            () => controller.isTrendingWishesDataExist.value
                ? AlignedGridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    itemCount: controller.lstTrendingWishesData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(12.sp),
                        decoration: BoxDecoration(
                            color: ThemeColors().greySocialButtons,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.sp))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                10.sp,
                              ) // Adjust the radius as needed
                                  ),
                              child: controller.lstTrendingWishesData[index]
                                              .userWishlistImages !=
                                          null &&
                                      controller.lstTrendingWishesData[index]
                                          .userWishlistImages!.isNotEmpty
                                  ? CachedNetworkImage(
                                      width: 141.w,
                                      height: 131.h,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          '${APIConfiguration.baseImage}${controller.lstTrendingWishesData[index].userWishlistImages?.first.fileName}',
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        AppAssets.icPlaceHolderLarge,
                                        width: 141.w,
                                        height: 131.h,
                                        fit: BoxFit.cover,
                                      ),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        AppAssets.icPlaceHolderLarge,
                                        width: 141.w,
                                        height: 131.h,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      AppAssets.icPlaceHolderLarge,
                                      width: 141.w,
                                      height: 131.h,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            TextWidget(
                              text: controller.lstTrendingWishesData[index]
                                      .productName ??
                                  '',
                              fontSize: 13.sp,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                              color: ThemeColors().homeTopCardTextColor,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            PrimaryButton(
                                titleText: AppLocalizations.of(context)!.wish,
                                onPressed: () {
                                  CustomBottomSheet.showCustomBottomSheet(
                                    context,
                                    ReWishBottomSheetContent(
                                      onConfirm: () async {
                                        Get.back();
                                        bool isVerified = await StorageService()
                                            .readBool(Keys.UserIsVarified);

                                        String? fileNameOne,
                                            fileNameTwo,
                                            fileNameThree;
                                        if (controller
                                                    .lstTrendingWishesData[
                                                        index]
                                                    .userWishlistImages !=
                                                null &&
                                            controller
                                                .lstTrendingWishesData[index]
                                                .userWishlistImages!
                                                .isNotEmpty) {
                                          fileNameOne = controller
                                              .lstTrendingWishesData[index]
                                              .userWishlistImages?[0]
                                              .fileName;
                                          fileNameTwo = controller
                                              .lstTrendingWishesData[index]
                                              .userWishlistImages?[1]
                                              .fileName;
                                          if (controller
                                                  .lstTrendingWishesData[index]
                                                  .userWishlistImages
                                                  ?.length ==
                                              3) {
                                            fileNameThree = controller
                                                .lstTrendingWishesData[index]
                                                .userWishlistImages?[2]
                                                .fileName;
                                          }
                                        }

                                        var args = {
                                          'pictureOne': fileNameOne,
                                          'pictureTwo': fileNameTwo,
                                          'pictureThree': fileNameThree,
                                          'productName': controller
                                                  .lstTrendingWishesData[index]
                                                  .productName ??
                                              '',
                                          'productDesc': controller
                                                  .lstTrendingWishesData[index]
                                                  .productDescription ??
                                              '',
                                          'quantity': controller
                                                  .lstTrendingWishesData[index]
                                                  .quantity ??
                                              '',
                                          'categoryId': controller
                                                  .lstTrendingWishesData[index]
                                                  .wishlistCategoryId ??
                                              '',
                                          'countryId': controller
                                                  .lstTrendingWishesData[index]
                                                  .countriesMaster
                                                  ?.id ??
                                              '',
                                          'wishRefId': controller
                                                  .lstTrendingWishesData[index]
                                                  .id ??
                                              '',
                                          'url': controller
                                                  .lstTrendingWishesData[index]
                                                  .productLink ??
                                              ''
                                        };
                                        if (isVerified) {
                                          Get.toNamed(
                                              Routes().getProductDetailScreen(),
                                              arguments: args);
                                        } else {
                                          await Get.toNamed(
                                            Routes().getCompleteAccountScreen(),
                                          );
                                          bool isVerifiedd =
                                              await StorageService().readBool(
                                                  Keys.UserIsVarified);

                                          if (isVerifiedd) {
                                            Get.toNamed(
                                                Routes()
                                                    .getProductDetailScreen(),
                                                arguments: args);
                                          }
                                        }
                                      },
                                      onCancel: () {
                                        Get.back();
                                      },
                                      pictureName: controller
                                                      .lstTrendingWishesData[
                                                          index]
                                                      .userWishlistImages !=
                                                  null &&
                                              controller
                                                  .lstTrendingWishesData[index]
                                                  .userWishlistImages!
                                                  .isNotEmpty
                                          ? controller
                                              .lstTrendingWishesData[index]
                                              .userWishlistImages!
                                              .first
                                              .fileName!
                                          : '',
                                      countryName: controller
                                              .lstTrendingWishesData[index]
                                              .countriesMaster
                                              ?.iso3 ??
                                          '',
                                      countryFlag: controller
                                              .lstTrendingWishesData[index]
                                              .countriesMaster
                                              ?.emoji ??
                                          '',
                                      userName:
                                          '${controller.lstTrendingWishesData[index].user?.firstName ?? ''} ${controller.lstTrendingWishesData[index].user?.lastName ?? ''}',
                                      userImage:
                                          '${APIConfiguration.baseImage}${controller.lstTrendingWishesData[index].user?.picture ?? ''}',
                                      productName: controller
                                              .lstTrendingWishesData[index]
                                              .productName ??
                                          '',
                                    ),
                                  );
                                },
                                backgroundColor:
                                    ThemeColors().secondaryColorTwo,
                                foregroundColor: ThemeColors().black,
                                textSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                buttonRadius: 10.sp,
                                width: 139.w,
                                height: 37.h)
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("No Data available"),
                  ),
          ),
        ),
      ],
    );
  }
}
