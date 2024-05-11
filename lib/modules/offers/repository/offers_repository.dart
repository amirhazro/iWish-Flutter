import 'dart:convert';

import 'package:iwish_flutter/modules/offers/models/offers_response_model.dart';
import 'package:iwish_flutter/modules/offers/models/payment_status_response_model.dart';
import 'package:iwish_flutter/services/ApiClient.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/http_exception.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/utils.dart';

class OffersRepository {
  APIClient client = APIClient();

  Future<OfferResponseModel> getOffersAgainstWish(
      int currentPage, int wishId, int? offerid) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    String url =
        '${APIConfiguration.baseUrl + EndPoints.getOfferAgainstWish}?id=&user_wishlist_id=$wishId&page=$currentPage';
    try {
      final response = await client.get(
        url,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return OfferResponseModel.fromJson(responseObject);
      } else if (response.statusCode == 401) {
        Utils.showSessionExpiredPopup();
        throw HttpException('Session Expired');
      } else {
        throw HttpException(responseObject['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postGetPayfortSdkToken(String deviceId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    var body = jsonEncode({
      "device_id": deviceId,
    });

    print(body);

    final response = await client.post(
      APIConfiguration.baseUrl + EndPoints.getSdkToken,
      headers: headers,
      body: body,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 422) {
      return responseObject;
    } else {
      throw HttpException(responseObject['message']);
    }
  }

  Future<PaymentStatusResponseModel> postPaymentStatus(
      String endPoint, String body) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    final response = await client.post(
      APIConfiguration.baseUrl + endPoint,
      headers: headers,
      body: body,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return PaymentStatusResponseModel.fromJson(responseObject);
    } else {
      throw HttpException(responseObject['message']);
    }
  }
}
