import 'package:flutter/material.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/modules/trips/controller/trips_controller.dart';
import 'package:iwish_flutter/modules/trips/models/trip_response_model.dart';
import 'package:iwish_flutter/modules/trips/models/trips_model.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/widgets/custom_secondary_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/widgets/loading_indicator.dart';
import 'package:iwish_flutter/widgets/primary_button.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';
import 'package:iwish_flutter/widgets/trip_to_from_widget.dart';

class TripsScreen extends StatelessWidget {
  static const id = "/TripsScreen";
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TripsController());
    return Scaffold(
      backgroundColor: ThemeColors().white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomSecondaryAppBar(
          title: AppLocalizations.of(context)!.trips,
          onBackPressed: () {},
          isBackButtonRequired: false,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.sp,
          vertical: 8.sp,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                bool isVerified =
                    await StorageService().readBool(Keys.UserIsVarified);
                if (isVerified) {
                  Get.toNamed(
                    Routes().getAddTripScreen(),
                  );
                } else {
                  await Get.toNamed(Routes().getCompleteAccountScreen(),
                      arguments: {'isTripFlow': true});

                  bool isVerifiedd =
                      await StorageService().readBool(Keys.UserIsVarified);

                  if (isVerifiedd) {
                    Get.toNamed(
                      Routes().getAddTripScreen(),
                      arguments: {'isVerifiedFlow': true},
                    );
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: ThemeColors()
                      .toggleSwitchBackgroundColorActive
                      .withOpacity(0.20),
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Image.asset(
                        AppAssets.icFlight,
                        width: 26.w,
                        height: 26.h,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextWidget(
                        text: AppLocalizations.of(context)!.tripAndEarn,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: ThemeColors().homeTopCardTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => PrimaryButton(
                      titleText: AppLocalizations.of(context)!.active,
                      onPressed: () {
                        controller.isActive.value = true;
                        controller.requestGetTripList();
                        controller.removePagingListener();
                      },
                      backgroundColor: controller.isActive.value
                          ? ThemeColors().secondaryColorTwo
                          : ThemeColors().platinum,
                      foregroundColor: ThemeColors().black,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      buttonRadius: 12.sp,
                      width: Get.width,
                      height: 46.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.sp,
                ),
                Expanded(
                  child: Obx(
                    () => PrimaryButton(
                      titleText: AppLocalizations.of(context)!.past,
                      onPressed: () async {
                        controller.isActive.value = false;
                        if (controller.pagingController.itemList != null &&
                            controller.pagingController.itemList!.isNotEmpty) {
                          controller.pagingController.itemList?.clear();
                        }
                        await controller.requestGetPastTripList(1);
                        controller.addPagingListener();
                      },
                      backgroundColor: !controller.isActive.value
                          ? ThemeColors().secondaryColorTwo
                          : ThemeColors().platinum,
                      foregroundColor: ThemeColors().black,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      buttonRadius: 12.sp,
                      width: Get.width,
                      height: 46.sp,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 32.h,
            ),
            Expanded(
              child: Obx(
                () => controller.isActive.value
                    ? _activeTripListWidget(context, controller)
                    : _pastTripsListWidget(context, controller),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pastTripsListWidget(
      BuildContext context, TripsController controller) {
    return PagedListView(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Trips>(
        itemBuilder: (context, item, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: ThemeColors().white,
              borderRadius: BorderRadius.all(
                Radius.circular(16.sp),
              ),
              border: Border.all(
                color: ThemeColors().greyBorder,
              ),
            ),
            child: _tripsListItem(
              context,
              item,
              controller,
              true,
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (context) =>
            const LoadingIndicator(),
        newPageProgressIndicatorBuilder: (context) => const LoadingIndicator(),
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: TextWidget(
            text: "No trips found",
            color: ThemeColors().homeTopCardTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _activeTripListWidget(
      BuildContext context, TripsController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Home',
                color: ThemeColors().homeTopCardTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Obx(
            () => controller.homeTrip.value != null
                ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                          color: ThemeColors().white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.sp),
                          ),
                          border: Border.all(color: ThemeColors().greyBorder)),
                      child: _homeTripsListItem(context,
                          controller.homeTrip.value!, controller, false),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWidget(
                        text: "No home trips available at the moment",
                        color: ThemeColors().homeTopCardTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Trips',
                color: ThemeColors().homeTopCardTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              TextWidget(
                text: '${controller.lstUpcomingTrips.length} Trips',
                color: ThemeColors().homeTopCardTextColor,
                fontWeight: FontWeight.w300,
                fontSize: 14.sp,
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Obx(
            () => controller.lstUpcomingTrips.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.lstUpcomingTrips.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => controller.navToTripDetailScreen(
                            controller.lstUpcomingTrips[index]),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          padding: EdgeInsets.all(16.sp),
                          decoration: BoxDecoration(
                              color: ThemeColors().white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.sp),
                              ),
                              border:
                                  Border.all(color: ThemeColors().greyBorder)),
                          child: _tripsListItem(
                            context,
                            controller.lstUpcomingTrips[index],
                            controller,
                            false,
                          ),
                        ),
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWidget(
                        text: "No trips available at the moment",
                        color: ThemeColors().homeTopCardTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                  ),
          )
        ],
      ),
    );
  }

  Widget _tripsListItem(BuildContext context, Trips item,
      TripsController controller, bool isPastTrip) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ToFromWidget(
          toCity: item.toCity?.name ?? '',
          fromCity: item.fromCity?.name ?? '',
          toCountry: item.toCity?.countryCode ?? '',
          fromCountry: item.fromCity?.countryCode ?? '',
          date: item.departureDate ?? '',
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                width: 231.w,
                height: 38.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: ThemeColors().primaryColorOne,
                  borderRadius: BorderRadius.circular(Constant.buttonRadius.sp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: AppLocalizations.of(context)!.takenOrders,
                      color: ThemeColors().black,
                      fontWeight: FontWeight.w500,
                      fontSize: 11.sp,
                    ),
                    TextWidget(
                      text: '${item.takenOrders ?? ''}',
                      color: ThemeColors().black,
                      fontWeight: FontWeight.w500,
                      fontSize: 11.sp,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 13.w,
            ),
            Visibility(
              visible: !isPastTrip,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: GestureDetector(
                onTap: () => controller.navToEditTripScreen(item),
                child: Container(
                  height: 38.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: ThemeColors().black,
                    borderRadius:
                        BorderRadius.circular(Constant.buttonRadius.sp),
                  ),
                  child: Image.asset(
                    AppAssets.icEdit,
                    color: ThemeColors().white,
                    width: 12.35.w,
                    height: 13.35.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _homeTripsListItem(BuildContext context, Home item,
      TripsController controller, bool isPastTrip) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: item.city?.name ?? '',
          color: ThemeColors().black,
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
        ),
        TextWidget(
          text: item.state ?? '',
          color: ThemeColors().black,
          fontWeight: FontWeight.w300,
          fontSize: 13.sp,
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                width: 231.w,
                height: 38.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: ThemeColors().primaryColorOne,
                  borderRadius: BorderRadius.circular(Constant.buttonRadius.sp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: AppLocalizations.of(context)!.takenOrders,
                      color: ThemeColors().black,
                      fontWeight: FontWeight.w500,
                      fontSize: 11.sp,
                    ),
                    TextWidget(
                      text: '${0}',
                      color: ThemeColors().black,
                      fontWeight: FontWeight.w500,
                      fontSize: 11.sp,
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   width: 13.w,
            // ),
            // Visibility(
            //   visible: !isPastTrip,
            //   maintainState: true,
            //   maintainAnimation: true,
            //   maintainSize: true,
            //   child: GestureDetector(
            //     onTap: () {},
            //     child: Container(
            //       height: 38.h,
            //       padding: EdgeInsets.symmetric(horizontal: 16.w),
            //       decoration: BoxDecoration(
            //         color: ThemeColors().black,
            //         borderRadius:
            //             BorderRadius.circular(Constant.buttonRadius.sp),
            //       ),
            //       child: Image.asset(
            //         AppAssets.icEdit,
            //         color: ThemeColors().white,
            //         width: 12.35.w,
            //         height: 13.35.h,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
