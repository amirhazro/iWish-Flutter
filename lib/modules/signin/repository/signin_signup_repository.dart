import 'dart:convert';

import 'package:iwish_flutter/modules/otp/models/otp_response_model.dart';
import 'package:iwish_flutter/modules/signin/models/countries_model.dart';
import 'package:iwish_flutter/utils/endpoints.dart';

import '../../../services/ApiClient.dart';
import '../../../utils/APIConfiguration.dart';
import '../../../utils/http_exception.dart';
import '../models/CountriesResponseModel.dart';
import '../models/CreateUserResponseModel.dart';

class SignInSignUpRepository {
  APIClient client = APIClient();

  Future<List<CountryViewModel>> getCountriesList(String searchText,
      {String? type}) async {
    final response = await client.get(
      '${APIConfiguration.baseUrl + EndPoints.countryList}?searchTerm=$searchText&type=$type',
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      List<CountryViewModel> countriesList = [];
      for (var obj
          in CountryResponseModel.fromJson(responseObject).data!.countries!) {
        countriesList.add(
          CountryViewModel(
            countryName: obj.name,
            dialCode: obj.phonecode?.startsWith('+') ?? false
                ? obj.phonecode
                : '+${obj.phonecode}',
            flagPath: obj.emoji ?? '🌍',
            countryId: obj.id ?? -1,
          ),
        );
      }

      return countriesList;
    } else {
      throw HttpException(responseObject['message']);
    }
  }

  Future<CreateUserResponseModel> postUserPhoneNumberForLoginOrSignup(
      String phoneNumber, String endpoint) async {
    final Map<String, String> data = {'phone': phoneNumber};
    final body = jsonEncode(data);

    final response = await client.post(
      APIConfiguration.baseUrl + endpoint,
      body: body,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return CreateUserResponseModel.fromJson(responseObject);
    } else {
      throw HttpException(responseObject['message']);
    }
  }

  Future<VerifiedOtpResponseModel> socialSignInVarification(
      String endpoint, String body) async {
    final response = await client.post(
      APIConfiguration.baseUrl + endpoint,
      body: body,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return VerifiedOtpResponseModel.fromJson(responseObject);
    } else {
      throw HttpException(responseObject['message']);
    }
  }
}
