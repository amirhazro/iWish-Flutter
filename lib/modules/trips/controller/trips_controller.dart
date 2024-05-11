import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/modules/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:iwish_flutter/modules/trips/models/trip_response_model.dart';
import 'package:iwish_flutter/modules/trips/models/trips_model.dart';
import 'package:iwish_flutter/modules/trips/repository/trips_repository.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/utils/utils.dart';

class TripsController extends GetxController {
  RxBool isActive = true.obs;
  final _bottomTabBar = Get.find<BottomNavigationController>();
  int totalPages = 0;
  int currentPage = 1;
  String status = 'open';
  final TripRepository _repository = TripRepository();
  final PagingController<int, Trips> pagingController =
      PagingController(firstPageKey: 1);

  Rx<Home?> homeTrip = Rx<Home?>(null);
  RxList<Trips> lstUpcomingTrips = <Trips>[].obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await requestGetTripList();
      // await requestGetPastTripList(1);
    });

    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  //region Navigation

  void navToEditTripScreen(Trips item) {
    Get.toNamed(Routes().getAddTripScreen(),
        arguments: {'item': item.toJson()});
  }

  void navToTripDetailScreen(Trips item) {
    Get.toNamed(Routes().getTripDetailScreen(), arguments: item.toJson());
  }

  void addPagingListener() {
    pagingController.addPageRequestListener((pageKey) async {
      await requestGetPastTripList(pageKey);
    });
  }

  void removePagingListener() {
    pagingController.removePageRequestListener((pageKey) async {
      await requestGetPastTripList(pageKey);
    });
  }

  //endregion

  //region API Calls

  Future<void> requestGetTripList() async {
    _bottomTabBar.isLoading.value = true;

    if (lstUpcomingTrips.isNotEmpty) {
      lstUpcomingTrips.clear();
    }

    try {
      var res = await _repository.getActiveTrips(status);
      if (res.data != null && res.data!.home != null) {
        homeTrip.value = res.data!.home;
      }
      if (res.data != null &&
          res.data!.comingTrips != null &&
          res.data!.comingTrips!.isNotEmpty) {
        lstUpcomingTrips.addAll(res.data!.comingTrips!);
        lstUpcomingTrips.refresh();
      }
    } catch (e) {
      e.printError();
      if (e.toString().contains('100')) {
        Utils.showNoInternetWarning();
      }
    } finally {
      _bottomTabBar.isLoading.value = false;
    }
  }

  Future<void> requestGetPastTripList(int pageKey) async {
    _bottomTabBar.isLoading.value = true;

    try {
      var res = await _repository.getPastTrips(pageKey, status);
      if (res.data != null &&
          res.data!.trips != null &&
          res.data!.trips!.isNotEmpty) {
        totalPages = res.data!.pagination!.pages!;
        currentPage = res.data!.pagination!.page!;

        final isLastPage = currentPage == totalPages;
        if (isLastPage) {
          print("isLastPage");
          pagingController.appendLastPage(res.data!.trips!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(res.data!.trips!, nextPageKey);
        }
      } else {
        pagingController.appendPage([], 1);
      }
    } catch (e) {
      pagingController.appendPage([], 1);
      e.printError();
      if (e.toString().contains('100')) {
        Utils.showNoInternetWarning();
      }
    } finally {
      _bottomTabBar.isLoading.value = false;
    }
  }
}
