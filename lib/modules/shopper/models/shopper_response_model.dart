import 'package:iwish_flutter/models/base_response_model.dart';
import 'package:iwish_flutter/models/user_address_response_model.dart';

class ShopperResponseModel extends BaseResponseModel {
  Data? data;

  ShopperResponseModel({
    String? status,
    int? statusCode,
    String? message,
    this.data,
    dynamic error,
  }) : super(
          error: error,
          message: message,
          status: status,
          statusCode: statusCode,
        );

  ShopperResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<AllShoppers>? allShoppers;
  Pagination? pagination;

  Data({this.allShoppers, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['allShoppers'] != null) {
      allShoppers = <AllShoppers>[];
      json['allShoppers'].forEach((v) {
        allShoppers!.add(AllShoppers.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allShoppers != null) {
      data['allShoppers'] = allShoppers!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class AllShoppers {
  int? id;
  String? firstName;
  String? lastName;
  String? picture;
  int? numOfWishes;
  List<UserAddresses>? userAddresses;

  AllShoppers({
    this.id,
    this.firstName,
    this.lastName,
    this.picture,
    this.numOfWishes,
    this.userAddresses,
  });

  AllShoppers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    picture = json['picture'];
    numOfWishes = json['num_of_wishes'];
    if (json['user_addresses'] != null) {
      userAddresses = <UserAddresses>[];
      json['user_addresses'].forEach((v) {
        userAddresses!.add(UserAddresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['picture'] = picture;
    data['num_of_wishes'] = numOfWishes;
    if (userAddresses != null) {
      data['user_addresses'] = userAddresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? pages;
  int? count;
  int? perPage;
  String? sortBy;
  String? sortOrder;

  Pagination(
      {this.page,
      this.pages,
      this.count,
      this.perPage,
      this.sortBy,
      this.sortOrder});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pages = json['pages'];
    count = json['count'];
    perPage = json['per_page'];
    sortBy = json['sort_by'];
    sortOrder = json['sort_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['pages'] = pages;
    data['count'] = count;
    data['per_page'] = perPage;
    data['sort_by'] = sortBy;
    data['sort_order'] = sortOrder;
    return data;
  }
}
