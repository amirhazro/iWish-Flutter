import 'package:iwish_flutter/models/base_response_model.dart';

class AddressResponseModel extends BaseResponseModel {
  Data? data;

  AddressResponseModel({
    String? status,
    int? statusCode,
    String? message,
    dynamic error,
    this.data,
  }) : super(
          error: error,
          message: message,
          status: status,
          statusCode: statusCode,
        );

  AddressResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? addressName;
  String? streetAddress;
  int? cityId;
  String? state;
  String? zipCode;
  String? setAs;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.userId,
      this.addressName,
      this.streetAddress,
      this.cityId,
      this.state,
      this.zipCode,
      this.setAs,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    addressName = json['address_name'];
    streetAddress = json['street_address'];
    cityId = json['city_id'];
    state = json['state'];
    zipCode = json['zip_code'];
    setAs = json['set_as'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['address_name'] = addressName;
    data['street_address'] = streetAddress;
    data['city_id'] = cityId;
    data['state'] = state;
    data['zip_code'] = zipCode;
    data['set_as'] = setAs;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
