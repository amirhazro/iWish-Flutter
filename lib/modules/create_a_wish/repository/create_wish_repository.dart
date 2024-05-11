import 'dart:convert';
import 'dart:io';
import 'package:iwish_flutter/services/ApiClient.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/utils.dart';

import '../../../utils/http_exception.dart';
import '../../complete_profile/models/address_list_response_model.dart';
import '../models/create_wish_response_model.dart';

class CreateWishRepository {
  APIClient client = APIClient();

  Future<AddressListResponseModel> getAddressList() async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };
    try {
      final response = await client.get(
        APIConfiguration.baseUrl + EndPoints.getAddresses,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return AddressListResponseModel.fromJson(responseObject);
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

  Future<CreateWishResponseModel> postCreateWishInfomation(
    String productName,
    String countryId,
    String productLink,
    String wishListCatId,
    String quantity,
    String productDesc,
    String addressId,
    int? refTrendingWishId,
    File imageFileOne,
    File imageFileTwo,
    File imageFileThree,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };
    Map<String, String> bodyParams;

    bodyParams = {
      'product_name': productName,
      'desired_country_id': countryId,
      'product_link': productLink,
      'wishlist_category_id': wishListCatId,
      'quantity': quantity,
      'product_description': productDesc,
      'address_id': addressId,
    };
    if (refTrendingWishId != null) {
      bodyParams['reference_wish_id'] = '$refTrendingWishId';
    }
    try {
      final response = await client.postMultipartRequest(
        APIConfiguration.baseUrl + EndPoints.createWishApi,
        headers,
        bodyParams,
        imageFileOne,
        imageFileTwo,
        imageFileThree,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return CreateWishResponseModel.fromJson(responseObject);
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

  Future<CreateWishResponseModel> postUpdateWishInfomation(
    int id,
    String productName,
    String countryId,
    String productLink,
    String wishListCatId,
    String quantity,
    String productDesc,
    String addressId,
    int? refTrendingWishId,
    File imageFileOne,
    File imageFileTwo,
    File imageFileThree,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };
    Map<String, String> bodyParams;

    bodyParams = {
      'id': "$id",
      'product_name': productName,
      'desired_country_id': countryId,
      'product_link': productLink,
      'wishlist_category_id': wishListCatId,
      'quantity': quantity,
      'product_description': productDesc,
      'address_id': addressId,
    };
    if (refTrendingWishId != null) {
      bodyParams['reference_wish_id'] = '$refTrendingWishId';
    }
    try {
      final response = await client.postMultipartRequest(
        APIConfiguration.baseUrl + EndPoints.updateAWish,
        headers,
        bodyParams,
        imageFileOne,
        imageFileTwo,
        imageFileThree,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return CreateWishResponseModel.fromJson(responseObject);
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
}
