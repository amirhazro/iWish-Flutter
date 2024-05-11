import 'dart:convert';

import 'package:http/http.dart';
import 'package:iwish_flutter/modules/chat/models/chat_file_upload_response_model.dart';
import 'package:iwish_flutter/modules/chat/models/chat_list_response_model.dart';
import 'package:iwish_flutter/modules/chat/models/chat_message_response_model.dart';
import 'package:iwish_flutter/services/ApiClient.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/APIConfiguration.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/keys.dart';
import 'package:iwish_flutter/utils/utils.dart';

import '../../../utils/http_exception.dart';

class ChatRepository {
  APIClient client = APIClient();

  Future<ChatListResponseModel> getChatListData() async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    var body =
        jsonEncode({'user_id': await StorageService().readInt(Keys.UserId)});

    final response = await client.post(
      APIConfiguration.baseUrl + EndPoints.getChatList,
      headers: headers,
      body: body,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return ChatListResponseModel.fromJson(responseObject);
    } else if (response.statusCode == 401) {
      Utils.showSessionExpiredPopup();
      throw HttpException('Session Expired');
    } else {
      throw HttpException(responseObject['message']);
    }
  }

  Future<ChatMessageResponseModel> getMessages(
      String threadId, int userId, int recieverId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    var body = jsonEncode({
      'user_id': await StorageService().readInt(Keys.UserId),
      'thread_id': threadId,
      'receiver_id': recieverId,
    });

    final response = await client.post(
      '${APIConfiguration.baseUrl + EndPoints.getChatMessages}?per_page=500',
      headers: headers,
      body: body,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return ChatMessageResponseModel.fromJson(responseObject);
    } else if (response.statusCode == 401) {
      Utils.showSessionExpiredPopup();
      throw HttpException('Session Expired');
    } else {
      throw HttpException(responseObject['message']);
    }
  }

  Future<ChatFileUploadResponseModel> uploadMedia(
      MultipartFile fileToUpload) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    final response = await client.postMultipartFile(
      APIConfiguration.baseUrl + EndPoints.uploadChatMedia,
      headers,
      fileToUpload,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return ChatFileUploadResponseModel.fromJson(responseObject);
    } else if (response.statusCode == 401) {
      Utils.showSessionExpiredPopup();
      throw HttpException('Session Expired');
    } else {
      throw HttpException(responseObject['message']);
    }
  }
}
