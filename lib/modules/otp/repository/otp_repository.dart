import 'dart:convert';

import 'package:iwish_flutter/modules/complete_profile/models/verify_email_response_model.dart';
import 'package:iwish_flutter/modules/otp/models/otp_response_model.dart';
import 'package:iwish_flutter/modules/otp/models/resend_otp_response_model.dart';
import 'package:iwish_flutter/services/storage_service.dart';
import 'package:iwish_flutter/utils/endpoints.dart';
import 'package:iwish_flutter/utils/keys.dart';

import '../../../services/ApiClient.dart';
import '../../../utils/APIConfiguration.dart';
import '../../../utils/http_exception.dart';
import '../models/resend_email_otp_response_model.dart';

class OTPRepository {
  APIClient client = APIClient();

  Future<VerifiedOtpResponseModel> postVerifyOtp(
      String phoneNumber, String code) async {
    final Map<String, String> data = {
      'phone': phoneNumber,
      'verify_code': code
    };
    final body = jsonEncode(data);

    final response = await client.post(
      APIConfiguration.baseUrl + EndPoints.verifyPhone,
      body: body,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return VerifiedOtpResponseModel.fromJson(responseObject);
    } else {
      throw HttpException(responseObject['message']);
    }
  }

  Future<ResendOtpResponseModel> postResendOtp(String phoneNumber) async {
    final Map<String, String> data = {
      'phone': phoneNumber,
    };
    final body = jsonEncode(data);

    final response = await client.post(
      APIConfiguration.baseUrl + EndPoints.resendOtp,
      body: body,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return ResendOtpResponseModel.fromJson(responseObject);
    } else {
      throw HttpException(responseObject['message']);
    }
  }

  Future<ResendEmailOtpResponseModel> postResendEmailOtp(String email) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    final Map<String, String> data = {
      'email': email,
    };
    final body = jsonEncode(data);

    final response = await client.post(
      APIConfiguration.baseUrl + EndPoints.resendEmailOtp,
      body: body,
      headers: headers,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return ResendEmailOtpResponseModel.fromJson(responseObject);
    } else {
      throw HttpException(responseObject['message']);
    }
  }

  Future<VerifyEmailResponseModel> postVarifyEmail(
      String email, String otp) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await StorageService().readString(Keys.Auth_Token) ?? ''
    };

    final Map<String, String> data = {'email': email, 'verify_code': otp};
    final body = jsonEncode(data);

    final response = await client.post(
      APIConfiguration.baseUrl + EndPoints.verifyEmail,
      headers: headers,
      body: body,
    );

    final responseObject = json.decode(response.body);

    if (response.statusCode == 200) {
      return VerifyEmailResponseModel.fromJson(responseObject);
    } else {
      throw HttpException(responseObject['message']);
    }
  }
}
