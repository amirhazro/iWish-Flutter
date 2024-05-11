import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/modules/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:iwish_flutter/modules/wishes/models/wish_detail_response_model.dart';
import 'package:iwish_flutter/modules/wishes/models/wishes_response_model.dart';
import 'package:iwish_flutter/modules/wishes/respository/wishes_repository.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/constants.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/rating_done_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WishesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _bottomTabBar = Get.find<BottomNavigationController>();
  final WishesRepository _repository = WishesRepository();
  String status = Constant.wishStatuses.first;
  int totalPages = 0;
  int currentPage = 1;

  double? ratingShopper;
  double? ratingProduct;

  TextEditingController textReviewTraveler = TextEditingController();
  TextEditingController textReviewIWish = TextEditingController();

  final PagingController<int, Wishes> pagingController =
      PagingController(firstPageKey: 1);

  late TabController tabController;

  final List<Tab> tabs = <Tab>[
    const Tab(
      text: "Requested",
    ),
    const Tab(
      text: "Processing",
    ),
    const Tab(
      text: "Shipped",
    ),
    const Tab(
      text: "Delivered",
    ),
    const Tab(
      text: "Inactive",
    ),
  ];

  @override
  void onInit() async {
    tabController = TabController(length: 5, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await requestGetWishesList(1);

      tabController.addListener(_handleTabChange);
      pagingController.addPageRequestListener((pageKey) async {
        await requestGetWishesList(pageKey);
      });
    });

    super.onInit();
  }

  void _handleTabChange() async {
    if (!tabController.indexIsChanging) {
      pagingController.itemList?.clear();
      status = Constant.wishStatuses[tabController.index];

      await requestGetWishesList(1);
    }
  }

  //Region API Call
  Future<void> requestGetWishesList(int pageKey, {String? searchText}) async {
    _bottomTabBar.isLoading.value = true;
    int userId = await StorageService().readInt(Keys.UserId);
    try {
      var res = await _repository.getWishes(
        pageKey,
        status,
        userId,
      );
      if (res.data != null &&
          res.data!.wishes != null &&
          res.data!.wishes!.isNotEmpty) {
        totalPages = res.data!.pagination!.pages!;
        currentPage = res.data!.pagination!.page!;

        final isLastPage = currentPage == totalPages;
        if (isLastPage) {
          pagingController.appendLastPage(res.data!.wishes!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(res.data!.wishes!, nextPageKey);
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

  Future<void> requestGetWisheDetail(
      int wishId, bool isView, bool isEdit) async {
    _bottomTabBar.isLoading.value = true;

    try {
      var res = await _repository.getWishDetail(wishId);
      if (res.data != null) {
        _navigation(res.data?.wish, isView, isEdit);
      } else {}
    } catch (e) {
      e.printError();
      if (e.toString().contains('100')) {
        Utils.showNoInternetWarning();
      }
    } finally {
      _bottomTabBar.isLoading.value = false;
    }
  }

  Future<void> requestDeleteWish(int wishId) async {
    _bottomTabBar.isLoading.value = true;

    try {
      var res = await _repository.deleteWish(wishId);
      if (res.data != null) {
        pagingController.itemList?.clear();
        requestGetWishesList(1);
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

  void _navigation(Wish? wish, bool isView, bool isEdit) {
    String? fileNameOne, fileNameTwo, fileNameThree;
    if (wish != null &&
        wish.userWishlistImages != null &&
        wish.userWishlistImages!.isNotEmpty) {
      fileNameOne = wish.userWishlistImages?[0].fileName;
      fileNameTwo = wish.userWishlistImages?[1].fileName;
      fileNameThree = wish.userWishlistImages?[2].fileName;
    }

    var args = {};
    if (isEdit || isView) {
      args.addAll({
        'wishId': wish?.id,
        'pictureOne': fileNameOne,
        'pictureTwo': fileNameTwo,
        'pictureThree': fileNameThree,
        'productName': wish?.productName ?? '',
        'productDesc': wish?.productDescription ?? '',
        'quantity': wish?.quantity ?? '',
        'categoryId': wish?.wishlistCategoryId ?? '',
        'countryId': wish?.countriesMaster?.id ?? '',
        'wishRefId': wish?.id ?? '',
        'url': wish?.productLink ?? '',
        'addressId': wish?.addressId ?? 0,
        'isEdit': isEdit,
      });
    } else {
      args.addAll({
        'wishId': wish?.id,
        'pictureOne': fileNameOne,
        'pictureTwo': fileNameTwo,
        'pictureThree': fileNameThree,
        'productName': wish?.productName ?? '',
        'productDesc': wish?.productDescription ?? '',
        'quantity': wish?.quantity ?? '',
        'categoryId': wish?.wishlistCategoryId ?? '',
        'countryId': wish?.countriesMaster?.id ?? '',
        'wishRefId': wish?.id ?? '',
        'url': wish?.productLink ?? '',
        'addressId': wish?.addressId ?? 0,
        'isAllEditAble': false,
        'isEdit': false,
      });
    }

    if (isView) {
      Get.toNamed(Routes().getViewWishScreen(), arguments: args);
    } else {
      Get.toNamed(Routes().getProductDetailScreen(), arguments: args);
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    pagingController.dispose();
    super.dispose();
  }

  Future<void> requestReviewTraveler(
      int userWishListId, int reviewedTo, BuildContext context) async {
    _bottomTabBar.isLoading.value = true;
    try {
      var res = await _repository.postReview(
        userWishListId,
        textReviewTraveler.text,
        textReviewIWish.text,
        ratingProduct ?? 0,
        ratingShopper ?? 0,
        reviewedTo,
      );

      if (res.data != null) {
        pagingController.itemList?.clear();
        await requestGetWishesList(1);
        if (context.mounted) {
          CustomBottomSheet.showCustomBottomSheet(
            Get.context,
            RatingDoneBottomSheet(
              title: AppLocalizations.of(context)!.ratingAdded,
              detail: AppLocalizations.of(context)!.ratingAddedDetail,
              onConfirm: () {
                Get.back();
              },
            ),
          );
        }
      }
    } catch (e) {
      e.printError();
      if (e.toString() == '100') {
        Utils.showNoInternetWarning();
      }
    } finally {
      _bottomTabBar.isLoading.value = false;
    }
  }

  Future<void> requestUpdateWishStatus(int id,
      {String status = 'requested'}) async {
    _bottomTabBar.isLoading.value = true;
    try {
      var res = await _repository.postUpdateWishStatus(id, status);

      if (res.data != null) {
        pagingController.itemList?.clear();
        requestGetWishesList(1);
      }
    } catch (e) {
      e.printError();
      if (e.toString() == '100') {
        Utils.showNoInternetWarning();
      }
    } finally {
      _bottomTabBar.isLoading.value = false;
    }
  }

  Future<void> requestConfirmDelivery(int id,
      {String status = 'accepted'}) async {
    _bottomTabBar.isLoading.value = true;
    try {
      var res = await _repository.postUpdateWishDelivery(id, status);

      if (res.data != null) {
        pagingController.itemList?.clear();
        requestGetWishesList(1);
      }
    } catch (e) {
      e.printError();
      if (e.toString() == '100') {
        Utils.showNoInternetWarning();
      }
    } finally {
      _bottomTabBar.isLoading.value = false;
    }
  }
}
