import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amazonpaymentservices/environment_type.dart';
import 'package:flutter_amazonpaymentservices/flutter_amazonpaymentservices.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:iwish_flutter/modules/offers/models/offers_response_model.dart';
import 'package:iwish_flutter/modules/offers/repository/offers_repository.dart';
import 'package:iwish_flutter/modules/wishes/respository/wishes_repository.dart';
import 'package:iwish_flutter/utils/bottom_sheet.dart';
import 'package:iwish_flutter/utils/custom_popup.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/routes.dart';
import 'package:iwish_flutter/utils/utils.dart';
import 'package:iwish_flutter/widgets/offer_confirmation_bottom_sheet.dart';

class OffersController extends GetxController {
  RxBool isLoading = false.obs;
  RxString titleWishNumber = '#'.obs;
  final OffersRepository _repository = OffersRepository();
  PagingController<int, Offers> pagingController =
      PagingController(firstPageKey: 1);

  int totalPages = 0;
  int currentPage = 1;

  @override
  void onInit() async {
    if (Get.arguments != null) {
      titleWishNumber.value = '# ${Get.arguments['itemId'] ?? ''}';
      await getOfferAgainstWish(Get.arguments['itemId'] ?? 0, 1);

      pagingController.addPageRequestListener((pageKey) async {
        await getOfferAgainstWish(Get.arguments['itemId'] ?? 0, pageKey);
      });
    }

    super.onInit();
  }

  //Region OfferConfirmationDialog

  Future<void> showOfferConfirmationBottomSheet(
      BuildContext context, Offers item, int index) async {
    CustomBottomSheet.showCustomBottomSheet(
        context,
        OfferConfirmationBottomSheet(
          item: pagingController.itemList![index],
          onConfirm: () async {
            Get.back();
            var deviceId = await FlutterAmazonpaymentservices.getUDID;

            var res = await _repository.postGetPayfortSdkToken(deviceId ?? '');
            print(res['error']['instance']['sdk_token']);
            payUsingPayFort(
                res['error']['instance']['sdk_token'],
                pagingController.itemList![index].id ?? 0,
                pagingController.itemList![index].totalPrice ?? 0,
                pagingController.itemList![index].traveler?.email ?? '',
                '${pagingController.itemList![index].userWishlistId ?? 0}',
                pagingController.itemList![index].traveler?.firstName ?? '');
          },
          onCancel: () {
            Get.back();
          },
        ));
  }

  //Region API Call
  Future<void> getOfferAgainstWish(int id, int pageKey) async {
    isLoading.value = true;
    try {
      var res = await _repository.getOffersAgainstWish(1, id, null);
      if (res.data != null &&
          res.data!.offers != null &&
          res.data!.offers!.isNotEmpty) {
        totalPages = res.data!.pagination!.pages!;
        currentPage = res.data!.pagination!.page!;

        final isLastPage = currentPage == totalPages;
        if (isLastPage) {
          pagingController.appendLastPage(res.data!.offers!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(res.data!.offers!, nextPageKey);
        }
      } else {
        pagingController.appendPage([], 1);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postPaymentStatus(
    bool isSuccess,
    int wishId,
    int offerId,
    int fortId,
    double amount,
    String name,
  ) async {
    isLoading.value = true;
    try {
      var body = jsonEncode({
        "user_wishlist_id": wishId,
        "offer_id": offerId,
        "fort_id": fortId,
        "amount": amount
      });

      var res = await _repository.postPaymentStatus(
          isSuccess ? EndPoints.paymentSuccess : EndPoints.paymentFailure,
          body);
      if (res.data != null) {
        if (isSuccess) {
          Get.toNamed(Routes().getPaymentSuccessScreen(), arguments: {
            'name': name,
            'amount': amount,
            'unit': res.data?.currency ?? '',
          });
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  //Payfort Region
  payUsingPayFort(
    String sdkToken,
    int offerId,
    double amount,
    String email,
    String merchantReference,
    String name,
  ) async {
    var requestParam = {
      "amount": adjustAmount(amount, 2).toString(),
      "command": "PURCHASE".toString(),
      "currency": "SAR".toString(),
      "customer_email": "talhamehtab2014@gmail.com".toString(),
      "language": "en".toString(),
      "merchant_reference": merchantReference.toString(),
      "sdk_token": sdkToken.toString(),
    };
    try {
      var result = await FlutterAmazonpaymentservices.normalPay(
        requestParam,
        EnvironmentType.sandbox,
        isShowResponsePage: false,
      );

      if (result['response_message'] == 'Success') {
        postPaymentStatus(
          true,
          int.parse(merchantReference),
          offerId,
          int.parse(result['fort_id'].toString()),
          amount,
          name,
        );
      }
    } on PlatformException catch (e) {
      dev.log("Error ${e.message} details:${e.details}");
      print(e.message);
      print(e.details);
      CustomPopup.showCustomDialog(Get.context!, "Error", e.message!);

      if (e.details['status'] == 03) {
        postPaymentStatus(
          false,
          int.parse(merchantReference),
          offerId,
          int.parse(e.details['fort_id']),
          amount,
          name,
        );
      }

      return;
    } on MissingPluginException {
      dev.log("Error");
      return;
    } catch (e) {
      dev.log("Error ${e.toString()}");
      return;
    }
  }

  int adjustAmount(double amount, int currencyDecimalCode) {
    int adjustedAmount = (amount * pow(10, currencyDecimalCode)).round();

    if (currencyDecimalCode == 3) {
      adjustedAmount = (adjustedAmount / 10).round() * 10;
    }

    return adjustedAmount;
  }

  Future<void> requestDeleteWish(int wishId) async {
    isLoading.value = true;

    try {
      var res = await WishesRepository().deleteWish(wishId);
      if (res.data != null) {
        Get.back(result: true);
      }
    } catch (e) {
      e.printError();
      if (e.toString().contains('100')) {
        Utils.showNoInternetWarning();
      }
    } finally {
      isLoading.value = false;
    }
  }
}
