import 'dart:convert';

import 'package:iwish_flutter/modules/complete_profile/models/city_response_model.dart';
import 'package:iwish_flutter/modules/complete_profile/models/city_view_model.dart';
import 'package:iwish_flutter/modules/signin/models/CountriesResponseModel.dart';
import 'package:iwish_flutter/modules/trips/models/currencies_view_model.dart';
import 'package:iwish_flutter/modules/trips/models/currency_conversion_response_model.dart';
import 'package:iwish_flutter/modules/trips/models/i_wish_service_charges_response_model.dart';
import 'package:iwish_flutter/modules/trips/models/make_offer_request_model.dart';
import 'package:iwish_flutter/modules/trips/models/make_offer_response_model.dart';
import 'package:iwish_flutter/modules/trips/models/offers_response_model.dart';
import 'package:iwish_flutter/modules/trips/models/past_trip_reponse_model.dart';
import 'package:iwish_flutter/modules/trips/models/trip_detail_response_model.dart';
import 'package:iwish_flutter/modules/trips/models/trip_response_model.dart';
import 'package:iwish_flutter/modules/wishes/models/delete_wish_response_model.dart';
import 'package:iwish_flutter/services/ApiClient.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/http_exception.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/utils.dart';

class TripRepository {
  APIClient client = APIClient();
  Future<TripResponseModel> getActiveTrips(String status) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    String url =
        '${APIConfiguration.baseUrl + EndPoints.getActiveTrips}?status=$status';

    final response = await client.get(
      url,
      headers: headers,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return TripResponseModel.fromJson(responseObject);
    } else if (response.statusCode == 401) {
      Utils.showSessionExpiredPopup();
      throw HttpException('Session Expired');
    } else {
      throw HttpException(responseObject['message']);
    }
  }

  Future<PastTripResponseModel> getPastTrips(
      int currentPage, String status) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };
    print(status);
    String url =
        '${APIConfiguration.baseUrl + EndPoints.getPastTrips}?page=$currentPage';
    try {
      final response = await client.get(
        url,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return PastTripResponseModel.fromJson(responseObject);
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

  Future<TripDetailResponseModel> getTripDetail(
      int currentPage, int tripId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    String url =
        '${APIConfiguration.baseUrl + EndPoints.getTripDetail}?id=$tripId&page=$currentPage';
    try {
      final response = await client.get(
        url,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return TripDetailResponseModel.fromJson(responseObject);
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

  Future<OffersResponseModel> getOffersList(
    int currentPage,
    int tripId,
    String status,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    String url =
        '${APIConfiguration.baseUrl + EndPoints.getOffers}?trip_id=$tripId&status=$status&page=$currentPage';
    try {
      final response = await client.get(
        url,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return OffersResponseModel.fromJson(responseObject);
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

  Future<List<CurrenciesViewModel>> getCountriesList({String? type}) async {
    final response = await client.get(
      '${APIConfiguration.baseUrl + EndPoints.countryList}?type=${type ?? ''}',
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      List<CurrenciesViewModel> countriesList = [];
      for (var obj
          in CountryResponseModel.fromJson(responseObject).data!.countries!) {
        countriesList.add(
          CurrenciesViewModel(
            currencyName: obj.currency ?? '',
            currencyCountry: obj.name ?? '',
            currencySymbol: obj.currencySymbol ?? '',
            countryFlag: obj.emoji ?? '🌍',
            countryId: obj.id ?? -1,
          ),
        );
      }

      return countriesList;
    } else {
      throw HttpException(responseObject['message']);
    }
  }

  Future<List<CityViewModel>> getCityData(
    String cityName,
  ) async {
    var url =
        '${APIConfiguration.baseUrl}${EndPoints.getCities}?searchTerm=$cityName';

    try {
      final response = await client.get(
        url,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        List<CityViewModel> lstData =
            (CityResponseModel.fromJson(responseObject).data?.cities ?? [])
                .map((obj) => CityViewModel(
                      cityName: obj.name ?? '',
                      cityId: obj.id ?? 0,
                      country: obj.countriesMaster?.name ?? '',
                      countryCode: obj.countriesMaster?.phonecode ?? '',
                      countryShortName: obj.countryCode ?? '',
                      countryId: obj.countryId ?? 0,
                      countryFlag: obj.countriesMaster?.emoji ?? '🌏',
                    ))
                .toList();
        return lstData;
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

  Future<MakeAnOfferResponseModel> postCreateOfferInfomation(
      MakeOfferRequestModel requestModel,
      {bool isUpdate = false}) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };
    var url = APIConfiguration.baseUrl +
        (isUpdate ? EndPoints.updateOffer : EndPoints.createOffer);
    var body = jsonEncode(requestModel.toJson());

    try {
      final response = await client.post(
        url,
        body: body,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return MakeAnOfferResponseModel.fromJson(responseObject);
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

  Future<CurrencyConversionResponseModel> postCurrencyConversion(String from,
      {String to = 'SAR', String amount = '1'}) async {
    var body = jsonEncode({"from": from, "to": to, "amount": amount});

    try {
      final response = await client.post(
        APIConfiguration.baseUrl + EndPoints.currencyConversion,
        body: body,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return CurrencyConversionResponseModel.fromJson(responseObject);
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

  Future<IWishServiceFeeResponseModel> getIwishServiceCharges() async {
    String url = APIConfiguration.baseUrl + EndPoints.getIWishServiceFee;
    try {
      final response = await client.get(
        url,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return IWishServiceFeeResponseModel.fromJson(responseObject);
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
    int offerId,
    int tripId,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    String url = APIConfiguration.baseUrl + EndPoints.reviewWish;

    Map<String, dynamic> bodyParams = {
      "user_wishlist_id": userWishlistId,
      "product_review": reviewProduct,
      "review": reviewTraveler,
      "product_rating": ratingProduct,
      "rating": ratingTraveler,
      "reviewed_to": reviewedTo,
      "offer_id": offerId,
      "trip_id": tripId
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
}
