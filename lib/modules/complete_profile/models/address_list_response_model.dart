import 'package:iwish_flutter/models/base_response_model.dart';
import 'package:iwish_flutter/models/user_address_response_model.dart';

class AddressListResponseModel extends BaseResponseModel {
  List<UserAddresses>? data;

  AddressListResponseModel({
    String? status,
    int? statusCode,
    String? message,
    dynamic error,
    this.data,
  }) : super(
          error: error,
          status: status,
          statusCode: statusCode,
          message: message,
        );

  AddressListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserAddresses>[];
      json['data'].forEach((v) {
        data!.add(UserAddresses.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? addressName;
  String? streetAddress;
  int? cityId;
  String? state;
  String? zipCode;
  String? setAs;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data(
      {this.id,
      this.userId,
      this.addressName,
      this.streetAddress,
      this.cityId,
      this.state,
      this.zipCode,
      this.setAs,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressName = json['address_name'];
    streetAddress = json['street_address'];
    cityId = json['city_id'];
    state = json['state'];
    zipCode = json['zip_code'];
    setAs = json['set_as'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['address_name'] = addressName;
    data['street_address'] = streetAddress;
    data['city_id'] = cityId;
    data['state'] = state;
    data['zip_code'] = zipCode;
    data['set_as'] = setAs;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    return data;
  }
}
