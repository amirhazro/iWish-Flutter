import 'dart:convert';

import 'package:get/get.dart';
import 'package:iwish_flutter/modules/trending_wishes/models/trending_wish_response_model.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/http_exception.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/utils.dart';

import '../../../services/ApiClient.dart';

class TrendingWishesRepository {
  APIClient client = APIClient();
  Future<TrendingWishResponseModel> getTrendingWishList(int currentPage,
      {String? searchValue, int? countryId, List<int>? lstCatIds}) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    String url =
        '${APIConfiguration.baseUrl + EndPoints.trendingWishList}?per_page=20&page=$currentPage';

    Map<String, dynamic> bodyParams = {};
    bodyParams.addIf(searchValue != null, "search", searchValue);
    bodyParams.addIf(countryId != null, "country_id", countryId);
    bodyParams.addIf(lstCatIds != null, "category_ids", lstCatIds);

    print(url);
    print(bodyParams);

    final response = await client.post(
      url,
      headers: headers,
      body: bodyParams.isEmpty ? null : json.encode(bodyParams),
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return TrendingWishResponseModel.fromJson(responseObject);
    } else if (response.statusCode == 401) {
      Utils.showSessionExpiredPopup();
      throw HttpException('Session Expired');
    } else {
      throw HttpException(responseObject['message']);
    }
  }
}
