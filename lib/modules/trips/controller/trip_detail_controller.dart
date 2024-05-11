import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/modules/complete_profile/models/city_view_model.dart';
import 'package:iwish_flutter/modules/trips/models/currencies_view_model.dart';
import 'package:iwish_flutter/modules/trips/models/make_offer_request_model.dart';
import 'package:iwish_flutter/modules/trips/models/offers_response_model.dart';
import 'package:iwish_flutter/modules/trips/models/trip_detail_response_model.dart';
import 'package:iwish_flutter/modules/trips/models/trips_model.dart';
import 'package:iwish_flutter/modules/trips/repository/trips_repository.dart';
import 'package:iwish_flutter/modules/wishes/respository/wishes_repository.dart';
import 'package:iwish_flutter/utils/app_assets.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/colors.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/make_offer_confirmation_bottom_sheet.dart';
import 'package:iwish_flutter/widgets/rating_done_bottom_sheet.dart';
import 'package:iwish_flutter/widgets/snackbar_popup.dart';
import 'package:iwish_flutter/widgets/trip_added_conformation_bottom_sheet_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  PagingController<int, Wishes> pagingController =
      PagingController(firstPageKey: 1);
  PagingController<int, Offers> pagingOfferController =
      PagingController(firstPageKey: 1);

  final TripRepository _repository = TripRepository();
  int totalPages = 0;
  int currentPage = 1;
  RxInt selectedTabIndex = 0.obs;

  RxBool isProceed = false.obs;
  RxBool isUpdate = false.obs;

  int? tripId;
  var debouncer = Debouncer(delay: const Duration(seconds: 1));

  double totalPrice = 0.00;
  double priceOfProduct = 0.00;
  double iwishFee = 0.00;
  double shippingCost = 0.00;
  double totalVat = 0.00;
  double myFees = 0.00;
  double totalValue = 0.00;

  RxBool isLoading = false.obs;
  late TabController tabController;
  final List<Tab> tabs = <Tab>[
    const Tab(
      text: "Wishes",
    ),
    const Tab(
      text: "Offers",
    ),
    const Tab(
      text: "To Deliver",
    ),
    const Tab(
      text: "Delivered",
    ),
    const Tab(
      text: "Disputed",
    ),
  ];

  //Make Offer variables
  FocusNode searchFocusNode = FocusNode();
  RxString searchHint = "Search city".obs;

  RxBool isCityLoading = false.obs;
  RxBool noCityDataAvailable = false.obs;

  Rx<CurrenciesViewModel?> currency = Rx<CurrenciesViewModel?>(null);
  List<String> currencyOptions = ["USD"];

  RxString setDelivery = 'Hand'.obs;
  List<String> deliveryOptions = ["Hand", "Courier"];

  int? toCityId, toCountryId, fromCityId, fromCountryId;
  Rx<String?> toCityName = Rx<String?>(null);
  Rx<String?> fromCityName = Rx<String?>(null);

  Rx<String?> toCityNameDetail = Rx<String?>(null);
  Rx<String?> fromCityNameDetail = Rx<String?>(null);

  Rx<String?> dateOfTrip = Rx<String?>(null);

  Rx<String?> fromCountryNameDetail = Rx<String?>(null);
  Rx<String?> toCountryNameDetail = Rx<String?>(null);

  RxList<CurrenciesViewModel> lstCurrenciesData = <CurrenciesViewModel>[].obs;
  RxList<CityViewModel> lstCityData = <CityViewModel>[].obs;

  TextEditingController expiaryTextController = TextEditingController();
  TextEditingController purchasedFromTextController = TextEditingController();
  TextEditingController productPriceTextController = TextEditingController();
  TextEditingController myFeesTextController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();

  Rx<String?> errorHoursErrorMsg = Rx<String?>(null);
  Rx<String?> errorPriceErrorMsg = Rx<String?>(null);
  Rx<String?> errorMyFeeErrorMsg = Rx<String?>(null);
  Rx<String?> currencyErrorMsg = Rx<String?>(null);
  Rx<String?> purchaseFromErrorMsg = Rx<String?>(null);

  Rx<String?> fromErrorMessage = Rx<String?>(null);
  Rx<String?> toErrorMessage = Rx<String?>(null);
  Rx<String?> weightErrorMessage = Rx<String?>(null);

  TextEditingController textReviewShopper = TextEditingController();
  TextEditingController textReviewIwish = TextEditingController();

  int selectedWishIndex = -1;

  String status = '';

  double? ratingShopper, ratingIwish;

  @override
  void onInit() async {
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(handleTabIndexChanging);
    if (Get.arguments != null) {
      Trips trip = Trips.fromJson(Get.arguments);
      tripId = trip.id;

      toCityNameDetail.value = trip.toCity?.name;
      fromCityNameDetail.value = trip.fromCity?.name;
      toCountryNameDetail.value = trip.toCity?.countryCode;
      fromCountryNameDetail.value = trip.fromCity?.countryCode;
      dateOfTrip.value = trip.departureDate;
    }
    addTextFieldsListeners();
    await requestGetCountriesList();
    await requestFetchCityData();
    await requestGetTripDetail(1);
    pagingController.addPageRequestListener((pageKey) async {
      await requestGetTripDetail(pageKey);
    });
    pagingOfferController.addPageRequestListener((pageKey) async {
      await requestGetOffersList(
        pageKey,
      );
    });

    super.onInit();
  }

  void addTextFieldsListeners() {
    expiaryTextController.addListener(() {
      if (expiaryTextController.text.isNotEmpty) {
        errorHoursErrorMsg.value = null;
      }
    });
    purchasedFromTextController.addListener(() {
      if (purchasedFromTextController.text.isNotEmpty) {
        purchaseFromErrorMsg.value = null;
      }
    });
    productPriceTextController.addListener(() {
      if (productPriceTextController.text.isNotEmpty) {
        errorPriceErrorMsg.value = null;
      }
    });
    myFeesTextController.addListener(() {
      if (myFeesTextController.text.isNotEmpty) {
        errorMyFeeErrorMsg.value = null;
      }
    });

    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        searchHint.value = '';
      } else {
        searchHint.value = 'Search city';
      }
    });

    cityNameController.addListener(() {
      if (cityNameController.text.length < 3) return;
      debouncer.call(() {
        requestFetchCityData();
      });
    });
  }

  handleTabIndexChanging() async {
    if (!tabController.indexIsChanging) {
      selectedTabIndex.value = tabController.index;
      if (selectedTabIndex.value == 0) {
        pagingController.itemList?.clear();
        await requestGetTripDetail(1);
      }

      if (selectedTabIndex.value == 1 ||
          selectedTabIndex.value == 2 ||
          selectedTabIndex.value == 3) {
        pagingOfferController.itemList?.clear();
        status = selectedTabIndex.value == 2
            ? 'processing'
            : selectedTabIndex.value == 3
                ? 'delivered'
                : '';

        await requestGetOffersList(1);
      }
    }
  }

  //region Calculation

  double calculateTotalPrice() {
    if (productPriceTextController.text.isNotEmpty) {
      int quantity;
      if (isUpdate.value) {
        quantity =
            pagingOfferController.itemList?[selectedWishIndex].quantity ?? 1;
      } else {
        quantity = pagingController.itemList?[selectedWishIndex].quantity ?? 1;
      }
      double price = double.parse(productPriceTextController.text);
      double? totalPrice = 0;
      totalPrice = quantity * price;
      return totalPrice;
    }

    return 0.00;
  }

  double calculateShipping() {
    return 0.00;
  }

  double calculateIWishFee(double totalprice, double feePercentage) {
    double fee = totalPrice * feePercentage;
    return fee;
  }

  double calculateTotal() {
    return totalPrice + iwishFee + shippingCost + totalVat + myFees;
  }

  //endRegion

  void moveToOfferConfirmationSheet() {
    bool isError = false;
    if (expiaryTextController.text.isEmpty) {
      errorHoursErrorMsg.value = 'Please enter expiry time';
      isError = true;
    } else if (double.parse(expiaryTextController.text) < 1 ||
        double.parse(expiaryTextController.text) > 120) {
      errorHoursErrorMsg.value = 'Expory time must be between 1 to 120 hours';
      isError = true;
    }
    if (purchasedFromTextController.text.isEmpty) {
      purchaseFromErrorMsg.value = 'Please enter purchased from';
      isError = true;
    }
    if (productPriceTextController.text.isEmpty) {
      errorPriceErrorMsg.value = 'Please enter product price';
      isError = true;
    }
    if (myFeesTextController.text.isEmpty) {
      errorMyFeeErrorMsg.value = 'Please enter your charges';
      isError = true;
    }

    if (currency.value == null) {
      currencyErrorMsg.value = 'Please select currency';
      isError = true;
    }

    if (isError) {
      return;
    }

    requestGetCurrencyRate(currency.value?.currencyName ?? '');
  }

  //region API CALL
  Future<void> requestGetTripDetail(
    int pageKey,
  ) async {
    try {
      var res = await _repository.getTripDetail(
        pageKey,
        tripId!,
      );
      if (res.data != null &&
          res.data!.wishes != null &&
          res.data!.wishes!.isNotEmpty) {
        totalPages = res.data!.pagination!.pages!;
        currentPage = res.data!.pagination!.page!;

        final isLastPage = currentPage == totalPages;
        if (isLastPage) {
          pagingController.appendLastPage(res.data!.wishes ?? []);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(res.data!.wishes!, nextPageKey);
        }
      } else {
        pagingController.appendPage([], 1);
      }
    } catch (e) {
      if (e.toString().contains('100')) {
        Utils.showNoInternetWarning();
      }
    } finally {}
  }

  Future<void> requestGetOffersList(
    int pageKey,
  ) async {
    try {
      print('status $status');
      var res = await _repository.getOffersList(
        pageKey,
        tripId!,
        status,
      );

      if (res.data != null &&
          res.data!.offers != null &&
          res.data!.offers!.isNotEmpty) {
        totalPages = res.data!.pagination!.pages!;
        currentPage = res.data!.pagination!.page!;

        final isLastPage = currentPage == totalPages;
        if (isLastPage) {
          pagingOfferController.appendLastPage(res.data!.offers ?? []);
        } else {
          final nextPageKey = pageKey + 1;
          pagingOfferController.appendPage(res.data!.offers!, nextPageKey);
        }
      } else {
        pagingOfferController.appendPage([], 1);
      }
    } catch (e) {
      if (e.toString().contains('100')) {
        Utils.showNoInternetWarning();
      }
    } finally {}
  }

  Future<void> requestGetCountriesList() async {
    try {
      var res = await _repository.getCountriesList(type: 'login');

      if (res.isNotEmpty) {
        lstCurrenciesData.addAll(res);
        lstCurrenciesData.refresh();
      }
    } catch (e) {
      SnackbarPopup.show(e.toString());
    } finally {}
  }

  Future<void> requestFetchCityData() async {
    if (lstCityData.isNotEmpty) {
      lstCityData.clear();
      lstCityData.refresh();
    }
    isCityLoading.value = true;
    try {
      var res = await _repository.getCityData(
        cityNameController.text,
      );
      if (res.isNotEmpty) {
        noCityDataAvailable.value = false;
        lstCityData.addAll(res);
        lstCityData.refresh();
      } else {
        noCityDataAvailable.value = true;
      }
    } catch (e) {
      e.printError();
      rethrow;
    } finally {
      isCityLoading.value = false;
    }
  }

  void requestPostOfferData() async {
    isProceed.value = true;
    try {
      MakeOfferRequestModel obj = MakeOfferRequestModel(
        userWishlistId: pagingController.itemList?[selectedWishIndex].id ?? 1,
        offeredTo: pagingController.itemList?[selectedWishIndex].committedBy,
        quantity: (pagingController.itemList?[selectedWishIndex].quantity ?? 1)
            .toString(),
        deliveryType: setDelivery.value == 'Hand' ? 'by_hand' : 'courier',
        tripId: tripId,
        iwishFee: iwishFee.toStringAsFixed(2),
        vatPrice: totalVat.toStringAsFixed(2),
        shippingFee: shippingCost.toStringAsFixed(2),
        totalUnitPrice: totalPrice.toPrecision(2),
        totalPrice: totalValue.toPrecision(2),
        travelerFee: myFees.toStringAsFixed(2),
        productPrice: priceOfProduct.toStringAsExponential(2),
        expiry: int.parse(expiaryTextController.text),
        purchaseFrom: purchasedFromTextController.text,
        currencyCode: 'SAR',
        shippingFrom: null,
        shippingTo: null,
        weight: null,
        height: null,
        width: null,
      );

      var res = await _repository.postCreateOfferInfomation(obj);
      if (res.data != null) {
        showOfferSentBottomSheet(Get.context!);
      }
    } catch (e) {
      e.printError();
      if (e.toString().contains('100')) {
        Utils.showNoInternetWarning();
      }
    } finally {
      isProceed.value = false;
    }
  }

  void requestPostUpdateOfferData({int? id}) async {
    isProceed.value = true;
    try {
      MakeOfferRequestModel obj = MakeOfferRequestModel(
        id: id,
        userWishlistId:
            pagingOfferController.itemList?[selectedWishIndex].id ?? 1,
        offeredTo: pagingOfferController.itemList?[selectedWishIndex].offeredTo,
        quantity:
            (pagingOfferController.itemList?[selectedWishIndex].quantity ?? 1)
                .toString(),
        deliveryType: setDelivery.value == 'Hand' ? 'by_hand' : 'courier',
        tripId: tripId,
        iwishFee: iwishFee.toStringAsFixed(2),
        vatPrice: totalVat.toStringAsFixed(2),
        shippingFee: shippingCost.toStringAsFixed(2),
        totalUnitPrice: totalPrice.toPrecision(2),
        totalPrice: totalValue.toPrecision(2),
        travelerFee: myFees.toStringAsFixed(2),
        productPrice: priceOfProduct.toStringAsExponential(2),
        expiry: int.parse(expiaryTextController.text),
        purchaseFrom: purchasedFromTextController.text,
        currencyCode: 'SAR',
        shippingFrom: null,
        shippingTo: null,
        weight: null,
        height: null,
        width: null,
      );

      var res =
          await _repository.postCreateOfferInfomation(obj, isUpdate: true);
      if (res.data != null) {
        showOfferSentBottomSheet(Get.context!);
      }
    } catch (e) {
      e.printError();
      if (e.toString().contains('100')) {
        Utils.showNoInternetWarning();
      }
    } finally {
      isProceed.value = false;
    }
  }

  showOfferSentBottomSheet(BuildContext context) {
    CustomBottomSheet.showCustomBottomSheet(
      context,
      modalColor: ThemeColors().white,
      WillPopScope(
        onWillPop: () {
          return Future<bool>.value(false);
        },
        child: TripAddedConfirmation(
          onConfirm: () {
            Get.back();
            Get.back();
            Get.back();
            clearData();
            if (pagingController.itemList != null &&
                pagingController.itemList!.isNotEmpty) {
              pagingController.itemList?.clear();
              requestGetTripDetail(1);
            }
            if (pagingOfferController.itemList != null &&
                pagingOfferController.itemList!.isNotEmpty) {
              pagingOfferController.itemList?.clear();
              requestGetOffersList(1);
            }
          },
          onCrossPressed: () {
            Get.back();
            Get.back();
            Get.back();
            clearData();
            if (pagingController.itemList != null &&
                pagingController.itemList!.isNotEmpty) {
              pagingController.itemList?.clear();
              requestGetTripDetail(1);
            }
            if (pagingOfferController.itemList != null &&
                pagingOfferController.itemList!.isNotEmpty) {
              pagingOfferController.itemList?.clear();
              requestGetOffersList(1);
            }
          },
          titleText: AppLocalizations.of(Get.context!)!.offerSent,
          descriptionText: AppLocalizations.of(Get.context!)!.offerSentDetail,
          boxText: AppLocalizations.of(Get.context!)!.offerSentBoxDetail,
          icon: AppAssets.icOfferSent,
          buttonText: AppLocalizations.of(Get.context!)!.backtoMatchedWishes,
          buttonBackgroundColor: ThemeColors().black,
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: Get.height * 0.9,
      ),
      enableDrag: false,
    );
  }

  clearData() {
    expiaryTextController.text = '';
    purchasedFromTextController.text = '';
    productPriceTextController.text = '';
    myFeesTextController.text = '';
    cityNameController.text = '';

    toCityId = null;
    toCountryId = null;
    fromCityId = null;
    fromCountryId = null;
    toCityName.value = null;
    fromCityName.value = null;

    isUpdate.value = false;

    setDelivery.value = 'Hand';
    currency.value = null;
  }

  Future<void> requestGetCurrencyRate(String currency) async {
    try {
      isProceed.value = true;
      var res = await _repository.postCurrencyConversion(currency);
      if (res.data != null) {
        requestGetIWishServiceFee(res.data?.result?.rate ?? 0.0);
        print(res.data?.result?.rate ?? '');
      }
    } catch (e) {
      e.printError();
    } finally {
      isProceed.value = false;
    }
  }

  Future<void> requestGetIWishServiceFee(double currencyRate) async {
    try {
      isProceed.value = true;
      var res = await _repository.getIwishServiceCharges();
      if (res.data != null) {
        totalPrice = calculateTotalPrice() * currencyRate;
        priceOfProduct =
            double.parse(productPriceTextController.text) * currencyRate;

        int percentage = 0;
        for (var obj in res.data!.serviceFee!) {
          if (double.parse(obj.minAmount!) <= totalPrice) {
            percentage = obj.percentage!;
          }
        }

        iwishFee = calculateIWishFee(totalPrice, (percentage / 100));
        totalVat = (iwishFee * 0.15);
        myFees = double.parse(myFeesTextController.text) * currencyRate;
        totalValue = calculateTotal();
        if (isUpdate.value) {
          CustomBottomSheet.showCustomBottomSheet(
            Get.context,
            MakeOfferConfirmationBottomSheet(
              onPressed: () {
                requestPostUpdateOfferData(
                    id: pagingOfferController.itemList?[selectedWishIndex].id ??
                        0);
              },
              productName: pagingOfferController
                      .itemList?[selectedWishIndex].userWishlist?.productName ??
                  '',
              unit: 'SAR',
              totalQuantity:
                  '${pagingOfferController.itemList?[selectedWishIndex].quantity ?? 0}',
              priceOfProduct: priceOfProduct.toStringAsFixed(2),
              totalPrice: totalPrice.toStringAsFixed(2),
              vat: totalVat.toStringAsFixed(2),
              iwishFee: iwishFee.toStringAsFixed(2),
              shippingCost: shippingCost.toStringAsFixed(2),
              totalValue: totalValue.toStringAsFixed(2),
              isUpdate: isUpdate.value,
            ),
          );
        } else {
          CustomBottomSheet.showCustomBottomSheet(
            Get.context,
            MakeOfferConfirmationBottomSheet(
              onPressed: () => requestPostOfferData(),
              productName:
                  pagingController.itemList?[selectedWishIndex].productName ??
                      '',
              unit: 'SAR',
              totalQuantity:
                  '${pagingController.itemList?[selectedWishIndex].quantity ?? 0}',
              priceOfProduct: priceOfProduct.toStringAsFixed(2),
              totalPrice: totalPrice.toStringAsFixed(2),
              vat: totalVat.toStringAsFixed(2),
              iwishFee: iwishFee.toStringAsFixed(2),
              shippingCost: shippingCost.toStringAsFixed(2),
              totalValue: totalValue.toStringAsFixed(2),
              isUpdate: isUpdate.value,
            ),
          );
        }
      }
    } catch (e) {
      e.printError();
    } finally {
      isProceed.value = false;
    }
  }

  Future<void> requestUpdateWishStatus(String status, int id) async {
    isLoading.value = true;
    try {
      var res = await WishesRepository().postUpdateWishStatus(id, status);
      if (res.data != null) {
        requestGetTripDetail(1);
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestReviewWisher(int userWishListId, int reviewedTo,
      int tripId, int offerId, BuildContext context) async {
    isLoading.value = true;
    try {
      var res = await _repository.postReview(
        userWishListId,
        textReviewShopper.text,
        textReviewIwish.text,
        ratingIwish ?? 0,
        ratingShopper ?? 0,
        reviewedTo,
        offerId,
        tripId,
      );

      if (res.data != null) {
        pagingOfferController.itemList?.clear();
        await requestGetOffersList(1);
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
      isLoading.value = false;
    }
  }
}
