import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwish_flutter/models/trending_wishes_model.dart';
import 'package:iwish_flutter/modules/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:iwish_flutter/modules/home/models/home_dashboard_response_model.dart';
import 'package:iwish_flutter/modules/home/repository/home_repository.dart';
import 'package:iwish_flutter/widgets/snackbar_popup.dart';

class HomeController extends GetxController {
  final _bottomTabController = Get.find<BottomNavigationController>();
  final _repository = HomeRespository();

  RxBool isTrendingWishesDataExist = false.obs;
  RxBool isTopShoppersDataExist = false.obs;

  RxList<TopShoppers> lstTopShoppersData = <TopShoppers>[].obs;
  RxList<TrendingWishes> lstTrendingWishesData = <TrendingWishes>[].obs;

  @override
  void onInit() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await requestGetHomeDashBoadrdData();
    });
    super.onInit();
  }

  //API Region
  Future<void> requestGetHomeDashBoadrdData() async {
    _bottomTabController.isLoading.value = true;
    try {
      var res = await _repository.getHomeData();
      if (res.data != null) {
        if (res.data!.topShoppers != null &&
            res.data!.topShoppers!.isNotEmpty) {
          if (lstTopShoppersData.isNotEmpty) {
            lstTopShoppersData.clear();
          }
          isTopShoppersDataExist.value = true;
          lstTopShoppersData.addAll(res.data!.topShoppers!);
          lstTopShoppersData.refresh();
        } else {
          isTopShoppersDataExist.value = false;
        }
        if (res.data!.trendingWishes != null &&
            res.data!.trendingWishes!.isNotEmpty) {
          if (lstTrendingWishesData.isNotEmpty) {
            lstTrendingWishesData.clear();
          }
          isTrendingWishesDataExist.value = true;
          lstTrendingWishesData.addAll(res.data!.trendingWishes!);
          lstTrendingWishesData.refresh();
        } else {
          isTrendingWishesDataExist.value = false;
        }
      }
    } catch (e) {
      isTrendingWishesDataExist.value = false;
      isTopShoppersDataExist.value = false;
      SnackbarPopup.show(e.toString(), isError: true, title: "Error");
    } finally {
      _bottomTabController.isLoading.value = false;
    }
  }
}
