import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:iwish_flutter/models/spoken_language_modal.dart';
import 'package:iwish_flutter/modules/complete_profile/models/address_response_model.dart';
import 'package:iwish_flutter/modules/complete_profile/models/city_response_model.dart';
import 'package:iwish_flutter/modules/complete_profile/models/city_view_model.dart';
import 'package:iwish_flutter/modules/complete_profile/models/language_response_model.dart';
import 'package:iwish_flutter/modules/complete_profile/models/update_profile_picture_response_model.dart';
import 'package:iwish_flutter/modules/complete_profile/models/validate_email_response_model.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/utils.dart';

import '../../../services/ApiClient.dart';
import '../../../utils/APIConfiguration.dart';
import '../../../utils/endpoints.dart';
import '../../../utils/http_exception.dart';
import '../../../utils/keys.dart';

class CompleteProfileRepository {
  APIClient client = APIClient();

  Future<List<SpokenLanguageModal>> getLangugages() async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };
    try {
      final response = await client.get(
        APIConfiguration.baseUrl + EndPoints.getLanguages,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        List<SpokenLanguageModal> lstData = [];
        for (var obj in LanguageResponseModel.fromJson(responseObject).data!) {
          lstData.add(SpokenLanguageModal(
            langugaeName: obj.languageName,
            languageCode: obj.languageCode,
            id: obj.id,
            isSelected: false.obs,
          ));
        }
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

  Future<ValidateEmailResponseModel> postValidateEmail(String email) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    final Map<String, String> data = {'email': email};
    final body = jsonEncode(data);
    try {
      final response = await client.post(
        APIConfiguration.baseUrl + EndPoints.validateEmail,
        headers: headers,
        body: body,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return ValidateEmailResponseModel.fromJson(responseObject);
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

  Future<ValidateEmailResponseModel> postProfileInformation(
    String email,
    String fname,
    String lname,
    String languagesId,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    final Map<String, String> data = {
      'email': email,
      'first_name': fname,
      'last_name': lname,
      'spoken_languages_ids': languagesId
    };

    final body = jsonEncode(data);
    try {
      final response = await client.post(
        APIConfiguration.baseUrl + EndPoints.completeProfile,
        headers: headers,
        body: body,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return ValidateEmailResponseModel.fromJson(responseObject);
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

  Future<UpdateProfilePictureResponseModel> postProfileImage(
      File imageFile) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };
    try {
      final response = await client.postUploadImage(
        APIConfiguration.baseUrl + EndPoints.updateProfileImage,
        headers,
        imageFile,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return UpdateProfilePictureResponseModel.fromJson(responseObject);
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

  Future<AddressResponseModel> postAddressInformation(
      String addressName,
      String streetAddress,
      int cityName,
      String stateName,
      String zipCode,
      String setAs,
      int countryId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    final Map<String, dynamic> data = {
      'address_name': addressName,
      'street_address': streetAddress,
      'city_id': cityName,
      'state': stateName,
      'zip_code': zipCode,
      'set_as': setAs,
      'country_id': countryId,
    };

    final body = jsonEncode(data);

    try {
      final response = await client.post(
        APIConfiguration.baseUrl + EndPoints.addUserAddress,
        headers: headers,
        body: body,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return AddressResponseModel.fromJson(responseObject);
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
}
