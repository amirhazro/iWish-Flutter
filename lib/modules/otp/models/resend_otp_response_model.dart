import 'package:iwish_flutter/models/base_response_model.dart';

class ResendOtpResponseModel extends BaseResponseModel {
  Data? data;

  ResendOtpResponseModel({
    String? status,
    int? statusCode,
    String? message,
    dynamic error,
    this.data,
  }) : super(
          message: message,
          status: status,
          error: error,
          statusCode: statusCode,
        );

  ResendOtpResponseModel.fromJson(Map<String, dynamic> json) {
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
  bool? isverified;
  bool? onbpostrequest;
  bool? onbposttrip;
  bool? contactnumberVerified;
  bool? emailVerified;
  String? contactnumber;
  String? numberCodeExpiry;
  String? createdAt;
  int? numberverificationcode;
  String? updatedAt;

  Data(
      {this.id,
      this.isverified,
      this.onbpostrequest,
      this.onbposttrip,
      this.contactnumberVerified,
      this.emailVerified,
      this.contactnumber,
      this.numberCodeExpiry,
      this.createdAt,
      this.numberverificationcode,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isverified = json['isverified'];
    onbpostrequest = json['onbpostrequest'];
    onbposttrip = json['onbposttrip'];
    contactnumberVerified = json['contactnumber_verified'];
    emailVerified = json['email_verified'];
    contactnumber = json['contactnumber'];
    numberCodeExpiry = json['number_code_expiry'];
    createdAt = json['createdAt'];
    numberverificationcode = json['numberverificationcode'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isverified'] = isverified;
    data['onbpostrequest'] = onbpostrequest;
    data['onbposttrip'] = onbposttrip;
    data['contactnumber_verified'] = contactnumberVerified;
    data['email_verified'] = emailVerified;
    data['contactnumber'] = contactnumber;
    data['number_code_expiry'] = numberCodeExpiry;
    data['createdAt'] = createdAt;
    data['numberverificationcode'] = numberverificationcode;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
