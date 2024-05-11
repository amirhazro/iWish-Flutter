import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/models/trending_wishes_model.dart';
import 'package:iwish_flutter/modules/interest/models/interst_chip_modal.dart';
import 'package:iwish_flutter/modules/interest/repository/interest_repository.dart';
import 'package:iwish_flutter/modules/signin/models/countries_model.dart';
import 'package:iwish_flutter/modules/signin/repository/signin_signup_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iwish_flutter/modules/trending_wishes/repository/trending_repository.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/snackbar_popup.dart';

class TrendingWishesController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isDesiredCountryDropDownVisible = false.obs;
  RxBool isCategoryDropDownVisible = false.obs;
  RxBool isTrendingWishesDataExist = true.obs;

  TextEditingController searchCountryController = TextEditingController();
  RxString searchCountryHint =
      AppLocalizations.of(Get.context!)!.searchByName.obs;
  FocusNode searchFocusNode = FocusNode();

  ScrollController scrollController = ScrollController();
  final PagingController<int, TrendingWishes> pagingController =
      PagingController(firstPageKey: 1);

  int totalPages = 0;
  int currentPage = 1;

  TextEditingController searchController = TextEditingController();

  RxString strCountry = AppLocalizations.of(Get.context!)!.selectCountry.obs;
  RxString strCategory = AppLocalizations.of(Get.context!)!.selectCategory.obs;

  RxList<TrendingWishes> lstTrendingWishesData = <TrendingWishes>[].obs;
  RxList<CountryViewModel> lstCountriesData = <CountryViewModel>[].obs;
  List<CountryViewModel> lstCountriesRawData = <CountryViewModel>[];
  RxList<InterestChipModal> lstInterestData = <InterestChipModal>[].obs;

  Debouncer debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  FocusNode searchNode = FocusNode();

  RxString hintText = "Search here...".obs;

  final TrendingWishesRepository _repository = TrendingWishesRepository();

  int? countryId;
  List<int>? lstCategoryFiler;

  @override
  void onInit() async {
    if (!await requestGetTrendingWishList(1)) return;
    await requestGetCountriesList();
    await requestGetInterestList();

    searchNode.addListener(() {
      if (searchNode.hasFocus) {
        hintText.value = "";
      } else {
        hintText.value = "Search here...";
      }
    });

    pagingController.addPageRequestListener((pageKey) async {
      await requestGetTrendingWishList(pageKey);
    });

    searchController.addListener(() async {
      if (searchController.text.length > 3) {
        debouncer.call(() async {
          requestSearchCountries();
        });
      } else if (searchController.text.isEmpty) {
        requestSearchCountries();
      }
    });

    searchCountryController.addListener(() {
      if (searchCountryController.text.isNotEmpty &&
          searchCountryController.text.length > 1) {
        // debouncer.call(() {
        if (lstCountriesData.isNotEmpty) {
          lstCountriesData.clear();
        }
        lstCountriesData.addAll(lstCountriesRawData
            .where((element) => element.countryName!
                .toLowerCase()
                .contains(searchCountryController.text.toLowerCase()))
            .toList());
        lstCountriesData.refresh();
        // });
      }
      if (searchFocusNode.hasFocus && searchCountryController.text.isEmpty) {
        if (lstCountriesData.isNotEmpty) {
          lstCountriesData.clear();
        }
        lstCountriesData.addAll(lstCountriesRawData);
        lstCountriesData.refresh();
      }
    });

    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        searchCountryHint.value = '';
      } else {
        searchCountryHint.value =
            AppLocalizations.of(Get.context!)!.searchByName;
      }
    });
    super.onInit();
  }

  void handleCountrySelection(int index) {
    isDesiredCountryDropDownVisible.value =
        !isDesiredCountryDropDownVisible.value;
    strCountry.value = lstCountriesData[index].countryName ?? '';
    countryId = lstCountriesData[index].countryId;
    searchCountryController.text = '';
    Utils.dismissKeyboard(Get.context!);
  }

  void handleCategorySelection(int index) {
    strCategory.value = '';
    lstInterestData[index].isSelected.value =
        !lstInterestData[index].isSelected.value;

    if (lstInterestData.any((element) => element.isSelected.value)) {
      strCategory.value = lstInterestData
          .where((element) => element.isSelected.value)
          .map((obj) => obj.title)
          .join(', ');
    } else {
      strCategory.value = AppLocalizations.of(Get.context!)!.selectCategory;
    }
  }

  void requestSearchCountries() {
    lstTrendingWishesData.clear();
    if (lstInterestData.where((p0) => p0.isSelected.value).isNotEmpty) {
      lstCategoryFiler = [];
      for (var obj in lstInterestData.where((p0) => p0.isSelected.value)) {
        lstCategoryFiler!.add(obj.id ?? 0);
      }
    }
    pagingController.itemList?.clear();
    requestGetTrendingWishList(1, searchText: searchController.text);
  }

  //API Region

  Future<bool> requestGetTrendingWishList(int pageKey,
      {String? searchText}) async {
    isLoading.value = true;

    try {
      var res = await _repository.getTrendingWishList(
        pageKey,
        searchValue: searchText,
        countryId: countryId,
        lstCatIds: lstCategoryFiler,
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
        isTrendingWishesDataExist.value = true;
      } else {
        isTrendingWishesDataExist.value = false;
      }
      isLoading.value = false;
      return true;
    } catch (e) {
      isTrendingWishesDataExist.value = false;
      if (e.toString() == '100') {
        SnackbarPopup.show(e.toString());
      }
      isLoading.value = false;
      return false;
    }
  }

  Future<void> requestGetCountriesList() async {
    isLoading.value = true;
    try {
      var res = await SignInSignUpRepository().getCountriesList('');

      if (res.isNotEmpty) {
        lstCountriesData.addAll(res);
        lstCountriesRawData.addAll(res);
        lstCountriesData.refresh();
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestGetInterestList() async {
    isLoading.value = true;
    try {
      var res = await InterestRepository().getInterestList();

      lstInterestData.addAll(res);
      lstInterestData.refresh();
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  void clearFilter() {
    strCountry.value = AppLocalizations.of(Get.context!)!.selectCountry;
    strCategory.value = AppLocalizations.of(Get.context!)!.selectCategory;
    isCategoryDropDownVisible.value = false;
    isDesiredCountryDropDownVisible.value = false;
    countryId = null;
    lstCategoryFiler = null;
    for (int i = 0; i < lstInterestData.length; i++) {
      lstInterestData[i].isSelected.value = false;
    }
    requestSearchCountries();
  }
}
