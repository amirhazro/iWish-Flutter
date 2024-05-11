import 'dart:convert';

import 'package:iwish_flutter/modules/create_a_wish/models/create_wish_response_model.dart';
import 'package:iwish_flutter/modules/wishes/models/delete_wish_response_model.dart';
import 'package:iwish_flutter/modules/wishes/models/wishes_response_model.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/http_exception.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/utils.dart';

import '../../../services/ApiClient.dart';
import '../models/wish_detail_response_model.dart';

class WishesRepository {
  APIClient client = APIClient();
  Future<WishesResponseModel> getWishes(
      int currentPage, String status, int userId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    String url =
        '${APIConfiguration.baseUrl + EndPoints.getWishes}?per_page=20&page=$currentPage';

    Map<String, dynamic> bodyParams = {"user_id": userId, "status": status};
    String body = json.encode(bodyParams);
    try {
      final response = await client.getWithBodyParams(
        url,
        body,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return WishesResponseModel.fromJson(responseObject);
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

  Future<WishDetailResponseModel> getWishDetail(
    int id,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    String url = APIConfiguration.baseUrl + EndPoints.getWishesDetail;

    Map<String, dynamic> bodyParams = {
      "id": id,
    };
    String body = json.encode(bodyParams);
    try {
      final response = await client.getWithBodyParams(
        url,
        body,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return WishDetailResponseModel.fromJson(responseObject);
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

  Future<DeleteWishResponseModel> deleteWish(
    int id,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    String url = APIConfiguration.baseUrl + EndPoints.deleteWish;

    Map<String, dynamic> bodyParams = {
      "id": id,
    };
    String body = json.encode(bodyParams);

    try {
      final response = await client.post(
        url,
        body: body,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return DeleteWishResponseModel.fromJson(responseObject);
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

  Future<DeleteWishResponseModel> postReview(
    int userWishlistId,
    String reviewProduct,
    String reviewTraveler,
    double ratingProduct,
    double ratingTraveler,
    int reviewedTo,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    String url = APIConfiguration.baseUrl + EndPoints.reviewTravler;

    Map<String, dynamic> bodyParams = {
      "user_wishlist_id": userWishlistId,
      "product_review": reviewProduct,
      "review": reviewTraveler,
      "product_rating": ratingProduct,
      "rating": ratingTraveler,
      "reviewed_to": reviewedTo,
    };
    String body = json.encode(bodyParams);
    try {
      final response = await client.post(
        url,
        body: body,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return DeleteWishResponseModel.fromJson(responseObject);
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

  Future<DeleteWishResponseModel> wishStatusChange(
    int userWishlistId,
    String status,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    String url = APIConfiguration.baseUrl + EndPoints.offerStatusChange;

    Map<String, dynamic> bodyParams = {
      "id": userWishlistId,
      "status": status,
    };
    String body = json.encode(bodyParams);
    try {
      final response = await client.post(
        url,
        body: body,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return DeleteWishResponseModel.fromJson(responseObject);
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

  Future<CreateWishResponseModel> postUpdateWishStatus(
    int id,
    String deliveryStatus,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };
    Map<String, String> bodyParams;

    bodyParams = {
      'id': "$id",
      'delivery_status': deliveryStatus,
    };
    try {
      final response = await client.post(
        APIConfiguration.baseUrl + EndPoints.changeWishStatus,
        headers: headers,
        body: jsonEncode(bodyParams),
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

  Future<CreateWishResponseModel> postUpdateWishDelivery(
    int id,
    String status,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };
    Map<String, String> bodyParams;

    bodyParams = {
      'id': "$id",
      'status': status,
    };
    try {
      final response = await client.post(
        APIConfiguration.baseUrl + EndPoints.offerStatusChange,
        headers: headers,
        body: jsonEncode(bodyParams),
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
