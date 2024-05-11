import 'package:iwish_flutter/models/base_response_model.dart';

class ResendEmailOtpResponseModel extends BaseResponseModel {
  Data? data;

  ResendEmailOtpResponseModel({
    String? status,
    int? statusCode,
    String? message,
    this.data,
    dynamic error,
  }) : super(
          status: status,
          statusCode: statusCode,
          message: message,
          error: error,
        );

  ResendEmailOtpResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? emailverificationcode;
  String? emailCodeExpiry;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.email,
      this.isverified,
      this.onbpostrequest,
      this.onbposttrip,
      this.emailVerified,
      this.emailverificationcode,
      this.emailCodeExpiry,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    isverified = json['isverified'];
    onbpostrequest = json['onbpostrequest'];
    onbposttrip = json['onbposttrip'];
    emailVerified = json['email_verified'];
    emailverificationcode = json['emailverificationcode'];
    emailCodeExpiry = json['email_code_expiry'];
    createdAt = json['createdAt'];
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
    data['emailverificationcode'] = emailverificationcode;
    data['email_code_expiry'] = emailCodeExpiry;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
