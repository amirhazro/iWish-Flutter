import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/modules/shopper/controller/shopper_controller.dart';
import 'package:iwish_flutter/modules/shopper/models/shopper_response_model.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';

import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:iwish_flutter/widgets/image_widget.dart';
import 'package:iwish_flutter/widgets/loading_indicator.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class ShopperScreen extends StatelessWidget {
  static const id = '/ShopperScreen';
  final controller = Get.find<ShopperController>();
  ShopperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors().white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: CustomSecondaryAppBar(
          title: AppLocalizations.of(context)!.allShoppers,
          onBackPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16.sp,
              right: 16.sp,
              top: 16.sp,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(
                      15.sp,
                    ),
                    decoration: BoxDecoration(
                      color: ThemeColors().lightRed,
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: AppLocalizations.of(context)!.area,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: ThemeColors().blackLightColor,
                        ),
                        Image.asset(
                          AppAssets.icArrowDown,
                          width: 12.w,
                          height: 12.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(
                      12.sp,
                    ),
                    decoration: BoxDecoration(
                        color: ThemeColors().white,
                        borderRadius: BorderRadius.circular(8.sp),
                        border: Border.all(color: ThemeColors().greyUnderline)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: AppLocalizations.of(context)!.mapView,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: ThemeColors().blackLightColor,
                        ),
                        Obx(
                          () => FlutterSwitch(
                            width: 40.w,
                            height: 25.h,
                            valueFontSize: 10.sp,
                            toggleSize: 22.sp,
                            value: controller.isMapView.value,
                            activeColor:
                                ThemeColors().greySwichBg.withOpacity(0.25),
                            inactiveColor:
                                ThemeColors().greySwichBg.withOpacity(0.25),
                            borderRadius: 14.sp,
                            padding: 3.0,
                            activeTextColor: ThemeColors().black,
                            activeToggleColor:
                                ThemeColors().thumbActiveColorOne,
                            inactiveToggleColor: ThemeColors().greyBottomBar,
                            showOnOff: false,
                            onToggle: (value) {
                              controller.isMapView.value = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => !controller.isMapView.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _shopperListWidget(context),
                    )
                  : mapView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget mapView() {
    return Padding(
      padding: EdgeInsets.only(top: 16.sp),
      child: GoogleMap(
        onMapCreated: controller.onMapCreated,
        myLocationButtonEnabled: false,
        mapType: MapType.terrain,
        initialCameraPosition: const CameraPosition(
          target: LatLng(33.738045, 73.084488),
          zoom: 10.0,
        ),
      ),
    );
  }

  Widget _shopperListWidget(BuildContext context) {
    return PagedListView(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<AllShoppers>(
        itemBuilder: (context, item, index) {
          return Container(
            margin: EdgeInsets.only(top: 16.h),
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
                color: ThemeColors().white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.sp),
                ),
                border: Border.all(
                  color: ThemeColors().greyBorder,
                )),
            child: Row(
              children: [
                ImageWidget(
                  imagePath: item.picture,
                  width: 110.w,
                  height: 110.h,
                  borderRadius: 10.sp,
                  placeHolderImage: AppAssets.icPlaceHolderSmall,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: '${item.firstName} ${item.lastName}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ThemeColors().black,
                    ),
                    TextWidget(
                      text:
                          '${item.numOfWishes ?? 0} ${AppLocalizations.of(context)!.trendingWishes}',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w300,
                      color: ThemeColors().greySmall,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: 0,
                          unratedColor: ThemeColors().unratedGrey,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        TextWidget(
                          text: "0",
                          color: ThemeColors().black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        TextWidget(
                          text: "(${item.numOfWishes ?? 0})",
                          color: ThemeColors().greySmall,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          AppAssets.icShopperLocation,
                          width: 30.w,
                          height: 30.h,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        TextWidget(
                          text: item.userAddresses != null
                              ? item.userAddresses!.isNotEmpty
                                  ? '${item.userAddresses?.first.city?.name ?? ''}, ${item.userAddresses?.first.city?.countryCode ?? ''}'
                                  : '--'
                              : '--',
                          color: ThemeColors().black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (context) =>
            const LoadingIndicator(),
        newPageProgressIndicatorBuilder: (context) => const LoadingIndicator(),
      ),
    );
  }
}
