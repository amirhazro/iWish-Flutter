import 'package:iwish_flutter/models/base_response_model.dart';

class AddInterestResponseModel extends BaseResponseModel {
  Data? data;

  AddInterestResponseModel(
      {String? status,
      int? statusCode,
      String? message,
      this.data,
      dynamic error})
      : super(
          error: error,
          message: message,
          status: status,
          statusCode: statusCode,
        );

  AddInterestResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  String? selectedInterests;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
      this.userId,
      this.selectedInterests,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    selectedInterests = json['selected_interests'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['selected_interests'] = selectedInterests;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
