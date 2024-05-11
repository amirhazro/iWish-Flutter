import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/modules/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:iwish_flutter/modules/home/screen/home_screen.dart';
import 'package:iwish_flutter/modules/more_settings/screen/more_screen.dart';
import 'package:iwish_flutter/modules/trips/screen/trips_screen.dart';
import 'package:iwish_flutter/modules/wishes/screen/wishes_screen.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/widgets/loading_overlay.dart';
import 'package:iwish_flutter/widgets/text_widget.dart';

class BottomNavigationScreen extends StatelessWidget {
  static const id = "/BottomNavigationScreen";
  BottomNavigationScreen({super.key});
  final controller = Get.find<BottomNavigationController>();

  final BoxDecoration unselectedBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(18.sp),
    color: ThemeColors().white,
  );

  final BoxDecoration selectedBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(18.sp),
    color: ThemeColors().primaryColorOne,
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          body: Obx(
            () => selectedNavScreen(
              context,
            ),
          ),
          bottomNavigationBar: Container(
            height: 95.h,
            color: ThemeColors().white,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        controller.tabIndex.value = 0;
                      },
                      child: buildBottomNavigationMenu(
                          AppAssets.icBtmNavHome,
                          AppAssets.icBtmNavHomeSlctd,
                          'Home',
                          controller.tabIndex.value == 0)),
                  GestureDetector(
                      onTap: () {
                        controller.tabIndex.value = 1;
                      },
                      child: buildBottomNavigationMenu(
                          AppAssets.icBtmNavTrips,
                          AppAssets.icBtmNavTripsSlctd,
                          'Trips',
                          controller.tabIndex.value == 1)),
                  GestureDetector(
                      onTap: () {
                        controller.tabIndex.value = 2;
                      },
                      child: buildBottomNavigationMenu(
                          AppAssets.icBtmNavWishes,
                          AppAssets.icBtmNavWishesSlctd,
                          'Wishes',
                          controller.tabIndex.value == 2)),
                  GestureDetector(
                    onTap: () {
                      controller.tabIndex.value = 3;
                    },
                    child: buildBottomNavigationMenu(
                      AppAssets.icBtmNavFriends,
                      AppAssets.icBtmNavFriendsSlctd,
                      'Friends',
                      controller.tabIndex.value == 3,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.tabIndex.value = 4;
                    },
                    child: buildBottomNavigationMenu(
                      AppAssets.icBtmNavMore,
                      AppAssets.icBtmNavMoreSlctd,
                      'More',
                      controller.tabIndex.value == 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildBottomNavigationMenu(
      String iconPath, String selectedIconPath, String label, bool isSelected,
      {double? width, double? height}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isSelected
            ? Image.asset(
                selectedIconPath,
                width: width ?? 38.sp,
                height: height ?? 38.sp,
              )
            : Image.asset(
                iconPath,
                width: width ?? 38.sp,
                height: height ?? 38.sp,
              ),
        SizedBox(
          height: 6.h,
        ),
        TextWidget(
          text: label,
          fontSize: 12.sp,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
          color: isSelected ? ThemeColors().black : ThemeColors().greyBottomBar,
        ),
      ],
    );
  }

  Widget selectedNavScreen(BuildContext context) {
    switch (controller.tabIndex.value) {
      case 0:
        return const HomeScreen();
      case 1:
        return const TripsScreen();
      case 2:
        return const WishesScreen();
      case 3:
        return const Center(child: Text('Chat'));
      case 4:
        return MoreScreen();
      default:
        return Container();
    }
  }
}
