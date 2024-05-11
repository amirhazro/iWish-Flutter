import 'dart:convert';

import 'package:iwish_flutter/modules/shopper/models/shopper_response_model.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/http_exception.dart';
import 'package:iwish_flutter/utils/utils.dart';

import '../../../services/ApiClient.dart';

class ShopperRepository {
  APIClient client = APIClient();
  Future<ShopperResponseModel> getAllShoppers(int currentPage) async {
    String url =
        '${APIConfiguration.baseUrl + EndPoints.getAllShopper}?per_page=20&page=$currentPage';

    final response = await client.get(
      url,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return ShopperResponseModel.fromJson(responseObject);
    } else if (response.statusCode == 401) {
      Utils.showSessionExpiredPopup();
      throw HttpException('Session Expired');
    } else {
      throw HttpException(responseObject['message']);
    }
  }
}
