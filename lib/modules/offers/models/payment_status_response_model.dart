import 'package:iwish_flutter/models/base_response_model.dart';

class PaymentStatusResponseModel extends BaseResponseModel {
  Data? data;

  PaymentStatusResponseModel({
    super.status,
    super.statusCode,
    super.message,
    this.data,
    super.error,
  });

  PaymentStatusResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class Data {
  String? responseCode;
  String? amount;
  String? responseMessage;
  String? signature;
  String? merchantIdentifier;
  String? accessCode;
  String? language;
  String? currency;
  String? fortId;
  String? command;
  String? status;

  Data(
      {this.responseCode,
      this.amount,
      this.responseMessage,
      this.signature,
      this.merchantIdentifier,
      this.accessCode,
      this.language,
      this.currency,
      this.fortId,
      this.command,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    amount = json['amount'];
    responseMessage = json['response_message'];
    signature = json['signature'];
    merchantIdentifier = json['merchant_identifier'];
    accessCode = json['access_code'];
    language = json['language'];
    currency = json['currency'];
    fortId = json['fort_id'];
    command = json['command'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['amount'] = amount;
    data['response_message'] = responseMessage;
    data['signature'] = signature;
    data['merchant_identifier'] = merchantIdentifier;
    data['access_code'] = accessCode;
    data['language'] = language;
    data['currency'] = currency;
    data['fort_id'] = fortId;
    data['command'] = command;
    data['status'] = status;
    return data;
  }
}
