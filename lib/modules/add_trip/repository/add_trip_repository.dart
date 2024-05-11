import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iwish_flutter/modules/add_trip/models/add_trip_response_model.dart';
import 'package:iwish_flutter/services/ApiClient.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/http_exception.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/utils.dart';

class AddTripRepository {
  final APIClient _client = APIClient();

  Future<AddTripResponseModel> postTripData(
      String tripType,
      String fromCityId,
      String toCityId,
      DateTime departureDate,
      String fromCountryId,
      String toCountryId,
      {DateTime? returnDate}) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };
    Map<String, String> bodyParams = {
      'trip_type': tripType,
      'from_cityid': fromCityId,
      'to_cityid': toCityId,
      'departure_date': DateFormat('yyyy-MM-dd').format(departureDate),
      'from_countryid': fromCountryId,
      'to_countryid': toCountryId,
    };

    bodyParams.addIf(returnDate != null, 'return_date',
        DateFormat('yyyy-MM-dd').format(returnDate ?? DateTime.now()));

    final body = jsonEncode(bodyParams);

    try {
      final response = await _client.post(
        APIConfiguration.baseUrl + EndPoints.addTrip,
        body: body,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return AddTripResponseModel.fromJson(responseObject);
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
