import 'dart:convert';

import 'package:get/get.dart';
import 'package:iwish_flutter/modules/interest/models/add_interest_response_model.dart';
import 'package:iwish_flutter/modules/interest/models/interest_response_model.dart';
import 'package:iwish_flutter/modules/interest/models/interst_chip_modal.dart';
import 'package:iwish_flutter/services/ApiClient.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/utils.dart';

import '../../../utils/http_exception.dart';

class InterestRepository {
  APIClient client = APIClient();

  Future<List<InterestChipModal>> getInterestList() async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };
    try {
      final response = await client.get(
        APIConfiguration.baseUrl + EndPoints.getInterestList,
        headers: headers,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        List<InterestChipModal> lstChipModal = [];
        for (var obj in InterestResponseModel.fromJson(responseObject).data!) {
          lstChipModal.add(
            InterestChipModal(
              obj.nameEn,
              obj.nameAr,
              obj.image,
              obj.id,
              false.obs,
            ),
          );
        }

        return lstChipModal;
      } else if (response.statusCode == 401) {
        Utils.showSessionExpiredPopup();
        throw HttpException('401');
      } else {
        throw HttpException(responseObject['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AddInterestResponseModel> postAddInterest(String ids) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };
    Map<String, String> map = {
      'selected_interests': ids,
    };

    String body = json.encode(map);

    try {
      final response = await client.post(
        APIConfiguration.baseUrl + EndPoints.selectInterest,
        headers: headers,
        body: body,
      );

      final responseObject = json.decode(response.body);

      if (response.statusCode == 200) {
        return AddInterestResponseModel.fromJson(responseObject);
      } else if (response.statusCode == 401) {
        Utils.showSessionExpiredPopup();
        throw HttpException('401');
      } else {
        throw HttpException(responseObject['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
