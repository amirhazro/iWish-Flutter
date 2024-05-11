import 'package:iwish_flutter/models/base_response_model.dart';
import 'package:iwish_flutter/models/trending_wishes_model.dart';

class HomeDashboardResponseModel extends BaseResponseModel {
  Data? data;

  HomeDashboardResponseModel({
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

  HomeDashboardResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<TopShoppers>? topShoppers;
  List<TrendingWishes>? trendingWishes;

  Data({this.topShoppers, this.trendingWishes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['topShoppers'] != null) {
      topShoppers = <TopShoppers>[];
      json['topShoppers'].forEach((v) {
        topShoppers!.add(TopShoppers.fromJson(v));
      });
    }
    if (json['trendingWishes'] != null) {
      trendingWishes = <TrendingWishes>[];
      json['trendingWishes'].forEach((v) {
        trendingWishes!.add(TrendingWishes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topShoppers != null) {
      data['topShoppers'] = topShoppers!.map((v) => v.toJson()).toList();
    }
    if (trendingWishes != null) {
      data['trendingWishes'] = trendingWishes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopShoppers {
  int? id;
  String? firstName;
  String? lastName;
  String? picture;
  int? numOfWishes;

  TopShoppers(
      {this.id, this.firstName, this.lastName, this.picture, this.numOfWishes});

  TopShoppers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    picture = json['picture'];
    numOfWishes = json['num_of_wishes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['picture'] = picture;
    data['num_of_wishes'] = numOfWishes;
    return data;
  }
}
