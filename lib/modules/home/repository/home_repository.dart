import 'dart:convert';

import 'package:iwish_flutter/modules/home/models/home_dashboard_response_model.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/http_exception.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/utils.dart';

import '../../../services/ApiClient.dart';

class HomeRespository {
  APIClient client = APIClient();

  Future<HomeDashboardResponseModel> getHomeData() async {
    print(await StorageService().readString(Keys.Auth_Token) ?? '');
    final response = await client.get(
      APIConfiguration.baseUrl + EndPoints.getHomeData,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return HomeDashboardResponseModel.fromJson(responseObject);
    } else if (response.statusCode == 401) {
      Utils.showSessionExpiredPopup();
      throw HttpException('Session Expired');
    } else {
      throw HttpException(responseObject['message']);
    }
  }
}
