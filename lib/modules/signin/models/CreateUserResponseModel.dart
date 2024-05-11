import '../../../models/base_response_model.dart';

class CreateUserResponseModel extends BaseResponseModel {
  Data? data;

  CreateUserResponseModel({
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

  CreateUserResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
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

  Data(
      {this.id,
      this.isverified,
      this.onbpostrequest,
      this.onbposttrip,
      this.contactnumberVerified,
      this.emailVerified,
      this.contactnumber,
      this.numberCodeExpiry,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isverified = json['isverified'];
    onbpostrequest = json['onbpostrequest'];
    onbposttrip = json['onbposttrip'];
    contactnumberVerified = json['contactnumber_verified'];
    emailVerified = json['email_verified'];
    contactnumber = json['contactnumber'];
    numberCodeExpiry = json['number_code_expiry'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isverified'] = this.isverified;
    data['onbpostrequest'] = this.onbpostrequest;
    data['onbposttrip'] = this.onbposttrip;
    data['contactnumber_verified'] = this.contactnumberVerified;
    data['email_verified'] = this.emailVerified;
    data['contactnumber'] = this.contactnumber;
    data['number_code_expiry'] = this.numberCodeExpiry;
    data['created_at'] = this.createdAt;
    return data;
  }
}
