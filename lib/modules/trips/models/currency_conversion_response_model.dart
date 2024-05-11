import 'package:iwish_flutter/models/base_response_model.dart';

class CurrencyConversionResponseModel extends BaseResponseModel {
  Data? data;

  CurrencyConversionResponseModel(
      {super.status, super.statusCode, super.message, this.data, super.error});

  CurrencyConversionResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? base;
  double? amount;
  Result? result;
  int? ms;

  Data({this.base, this.amount, this.result, this.ms});

  Data.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    if (json['amount'] is int) {
      amount = json['amount'].toDouble();
    } else {
      amount = json['amount'];
    }
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    ms = json['ms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base'] = base;
    data['amount'] = amount;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['ms'] = ms;
    return data;
  }
}

class Result {
  double? pKR;
  double? rate;

  Result({this.pKR, this.rate});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['PKR'] is int) {
      pKR = json['PKR'].toDouble();
    } else {
      pKR = json['PKR'];
    }
    if (json['rate'] is int) {
      rate = json['rate'].toDouble();
    } else {
      rate = json['rate'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PKR'] = pKR;
    data['rate'] = rate;
    return data;
  }
}
