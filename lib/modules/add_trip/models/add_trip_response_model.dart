import 'package:iwish_flutter/models/base_response_model.dart';

class AddTripResponseModel extends BaseResponseModel {
  Data? data;

  AddTripResponseModel({
    super.status,
    super.statusCode,
    super.message,
    this.data,
    super.error,
  });

  AddTripResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? tripStatus;
  int? id;
  String? userId;
  String? tripType;
  int? fromCityid;
  int? fromCountryid;
  int? toCityid;
  int? toCountryid;
  dynamic residentCityid;
  dynamic residentCountryid;
  String? departureDate;
  String? returnDate;
  int? isResident;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.tripStatus,
      this.id,
      this.userId,
      this.tripType,
      this.fromCityid,
      this.fromCountryid,
      this.toCityid,
      this.toCountryid,
      this.residentCityid,
      this.residentCountryid,
      this.departureDate,
      this.returnDate,
      this.isResident,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    tripStatus = json['trip_status'];
    id = json['id'];
    userId = json['user_id'];
    tripType = json['trip_type'];
    fromCityid = json['from_cityid'];
    fromCountryid = json['from_countryid'];
    toCityid = json['to_cityid'];
    toCountryid = json['to_countryid'];
    residentCityid = json['resident_cityid'];
    residentCountryid = json['resident_countryid'];
    departureDate = json['departure_date'];
    returnDate = json['return_date'];
    isResident = json['is_resident'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trip_status'] = tripStatus;
    data['id'] = id;
    data['user_id'] = userId;
    data['trip_type'] = tripType;
    data['from_cityid'] = fromCityid;
    data['from_countryid'] = fromCountryid;
    data['to_cityid'] = toCityid;
    data['to_countryid'] = toCountryid;
    data['resident_cityid'] = residentCityid;
    data['resident_countryid'] = residentCountryid;
    data['departure_date'] = departureDate;
    data['return_date'] = returnDate;
    data['is_resident'] = isResident;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
