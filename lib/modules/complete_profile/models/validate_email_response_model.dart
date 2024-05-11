import 'package:iwish_flutter/models/base_response_model.dart';

class ValidateEmailResponseModel extends BaseResponseModel {
  Data? data;

  ValidateEmailResponseModel({
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

  ValidateEmailResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? email;
  bool? isverified;
  bool? onbpostrequest;
  bool? onbposttrip;
  bool? emailVerified;
  String? createdAt;
  int? emailverificationcode;
  String? emailCodeExpiry;
  String? updatedAt;

  Data(
      {this.id,
      this.email,
      this.isverified,
      this.onbpostrequest,
      this.onbposttrip,
      this.emailVerified,
      this.createdAt,
      this.emailverificationcode,
      this.emailCodeExpiry,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    isverified = json['isverified'];
    onbpostrequest = json['onbpostrequest'];
    onbposttrip = json['onbposttrip'];
    emailVerified = json['email_verified'];
    createdAt = json['createdAt'];
    emailverificationcode = json['emailverificationcode'];
    emailCodeExpiry = json['email_code_expiry'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['isverified'] = isverified;
    data['onbpostrequest'] = onbpostrequest;
    data['onbposttrip'] = onbposttrip;
    data['email_verified'] = emailVerified;
    data['createdAt'] = createdAt;
    data['emailverificationcode'] = emailverificationcode;
    data['email_code_expiry'] = emailCodeExpiry;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
