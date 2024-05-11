class BaseResponseModel {
  String? status;
  int? statusCode;
  String? message;
  dynamic error;

  BaseResponseModel({
    this.status,
    this.message,
    this.statusCode,
    this.error,
  });

  BaseResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
    error = json['error'];
  }
}
