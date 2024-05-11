import 'package:iwish_flutter/models/base_response_model.dart';

class LanguageResponseModel extends BaseResponseModel {
  List<Data>? data;

  LanguageResponseModel({
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

  LanguageResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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
  String? languageCode;
  String? languageName;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.languageCode,
      this.languageName,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageCode = json['language_code'];
    languageName = json['language_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['language_code'] = languageCode;
    data['language_name'] = languageName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
