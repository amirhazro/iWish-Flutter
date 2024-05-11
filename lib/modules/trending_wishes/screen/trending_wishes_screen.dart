import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/models/trending_wishes_model.dart';
import 'package:iwish_flutter/modules/trending_wishes/controller/trending_wishes_controller.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:iwish_flutter/widgets/loading_indicator.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/rewish_wish_bottom_sheet_widget.dart';
import 'package:iwish_flutter/widgets/search_filter.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

import '../../../utils/app_assets.dart';

class TrendingWishesScreen extends StatelessWidget {
  static const id = '/TrendingWishesScreen';
  final controller = Get.find<TrendingWishesController>();
  TrendingWishesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.dismissKeyboard(context),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
          child: CustomSecondaryAppBar(
            title: AppLocalizations.of(context)!.trendingWishes,
            onBackPressed: () {
              Get.back();
            },
            isFilterButton: true,
            onFilterPressed: () {
              CustomBottomSheet.showCustomBottomSheet(
                context,
                SearchFilter(
                  controller: controller,
                  onApply: () {
                    Get.back();
                    controller.requestSearchCountries();
                  },
                  onCancel: () {
                    Get.back();
                    controller.clearFilter();
                  },
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 16.sp,
            right: 16.sp,
            top: 16.sp,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 40.sp,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ThemeColors().greyBorder,
                        ),
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(() => TextField(
                                  focusNode: controller.searchNode,
                                  controller: controller.searchController,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: ThemeColors().homeTopCardTextColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: controller.hintText.value,
                                    isDense: true,
                                    hintStyle: TextStyle(
                                        color:
                                            ThemeColors().homeTopCardTextColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r"[a-zA-Z0-9\-()_.,\'\‘\’ ]")),
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              AppAssets.icSearch,
                              width: 20.5.w,
                              height: 20.5.h,
                              color: ThemeColors().argent,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    flex: 1,
                    child: PrimaryButton(
                      titleText:
                          AppLocalizations.of(context)!.createAWishCapital,
                      onPressed: () async {
                        bool isVerified = await StorageService()
                            .readBool(Keys.UserIsVarified);
                        if (isVerified) {
                          Get.toNamed(Routes().getProductDetailScreen());
                        } else {
                          Get.toNamed(Routes().getCompleteAccountScreen());
                          bool isVerifiedd = await StorageService()
                              .readBool(Keys.UserIsVarified);

                          if (isVerifiedd) {
                            Get.toNamed(Routes().getProductDetailScreen());
                          }
                        }
                      },
                      backgroundColor: ThemeColors().greySocialButtons,
                      foregroundColor: ThemeColors().homeTopCardTextColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      buttonRadius: 8.sp,
                      width: Get.width,
                      height: 40.h,
                    ),
                  )
                ],
              ),
              Expanded(
                child: _trendingWishes(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trendingWishes(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Obx(
        () => controller.isTrendingWishesDataExist.value
            ? PagedMasonryGridView.count(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<TrendingWishes>(
                  itemBuilder: (context, item, index) {
                    return Container(
                      padding: EdgeInsets.all(14.sp),
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
                                    10.sp) // Adjust the radius as needed
                                ),
                            child: item.userWishlistImages != null &&
                                    item.userWishlistImages!.isNotEmpty
                                ? CachedNetworkImage(
                                    width: 141.w,
                                    height: 131.h,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        '${APIConfiguration.baseImage}${item.userWishlistImages?.first.fileName}',
                                    placeholder: (context, url) => Image.asset(
                                      AppAssets.icPlaceHolderLarge,
                                      width: 141.w,
                                      height: 131.h,
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, url, error) =>
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
                            text: item.productName ?? '',
                            fontSize: 13.sp,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            color: ThemeColors().black,
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
                                      if (item.userWishlistImages != null &&
                                          item.userWishlistImages!.isNotEmpty) {
                                        fileNameOne = item
                                            .userWishlistImages?[0].fileName;
                                        fileNameTwo = item
                                            .userWishlistImages?[1].fileName;
                                        fileNameThree = item
                                            .userWishlistImages?[2].fileName;
                                      }

                                      var args = {
                                        'pictureOne': fileNameOne,
                                        'pictureTwo': fileNameTwo,
                                        'pictureThree': fileNameThree,
                                        'productName': item.productName ?? '',
                                        'productDesc':
                                            item.productDescription ?? '',
                                        'quantity': item.quantity ?? '',
                                        'categoryId':
                                            item.wishlistCategoryId ?? '',
                                        'countryId':
                                            item.countriesMaster?.id ?? '',
                                        'wishRefId': item.id ?? '',
                                        'url': item.productLink ?? ''
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
                                            await StorageService()
                                                .readBool(Keys.UserIsVarified);

                                        if (isVerifiedd) {
                                          Get.toNamed(
                                            Routes().getProductDetailScreen(),
                                            arguments: args,
                                          );
                                        }
                                      }
                                    },
                                    onCancel: () {
                                      Get.back();
                                    },
                                    pictureName: item.userWishlistImages !=
                                                null &&
                                            item.userWishlistImages!.isNotEmpty
                                        ? item
                                            .userWishlistImages!.first.fileName!
                                        : '',
                                    countryName:
                                        item.countriesMaster?.iso3 ?? '',
                                    countryFlag:
                                        item.countriesMaster?.emoji ?? '',
                                    userName:
                                        '${item.user?.firstName ?? ''} ${item.user?.lastName ?? ''}',
                                    userImage:
                                        '${APIConfiguration.baseImage}${item.user?.picture ?? ''}',
                                    productName: item.productName ?? '',
                                  ),
                                );
                              },
                              backgroundColor: ThemeColors().secondaryColorTwo,
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
                  firstPageProgressIndicatorBuilder: (context) =>
                      const LoadingIndicator(),
                  newPageProgressIndicatorBuilder: (context) =>
                      const LoadingIndicator(),
                ),
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
              )
            : const Center(
                child: Text("No data available"),
              ),
      ),
    );
  }
}
