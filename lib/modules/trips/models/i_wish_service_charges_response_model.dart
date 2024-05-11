import 'package:iwish_flutter/models/base_response_model.dart';

class IWishServiceFeeResponseModel extends BaseResponseModel {
  Data? data;

  IWishServiceFeeResponseModel(
      {super.status, super.statusCode, super.message, this.data, super.error});

  IWishServiceFeeResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<ServiceFee>? serviceFee;

  Data({this.serviceFee});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['serviceFee'] != null) {
      serviceFee = <ServiceFee>[];
      json['serviceFee'].forEach((v) {
        serviceFee!.add(ServiceFee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (serviceFee != null) {
      data['serviceFee'] = serviceFee!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceFee {
  int? id;
  String? minAmount;
  String? maxAmount;
  int? percentage;
  String? currency;

  ServiceFee(
      {this.id,
      this.minAmount,
      this.maxAmount,
      this.percentage,
      this.currency});

  ServiceFee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    percentage = json['percentage'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['min_amount'] = minAmount;
    data['max_amount'] = maxAmount;
    data['percentage'] = percentage;
    data['currency'] = currency;
    return data;
  }
}
