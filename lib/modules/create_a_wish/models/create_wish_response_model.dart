import 'package:iwish_flutter/models/base_response_model.dart';

class CreateWishResponseModel extends BaseResponseModel {
  Data? data;

  CreateWishResponseModel({
    String? status,
    int? statusCode,
    String? message,
    dynamic error,
    this.data,
  }) : super(
          status: status,
          statusCode: statusCode,
          message: message,
          error: error,
        );

  CreateWishResponseModel.fromJson(Map<String, dynamic> json) {
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
  UserWish? userWish;
  List<UserWishlistImages>? userWishlistImages;

  Data({this.userWish, this.userWishlistImages});

  Data.fromJson(Map<String, dynamic> json) {
    userWish =
        json['userWish'] != null ? UserWish.fromJson(json['userWish']) : null;
    if (json['user_wishlist_images'] != null) {
      userWishlistImages = <UserWishlistImages>[];
      json['user_wishlist_images'].forEach((v) {
        userWishlistImages!.add(UserWishlistImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userWish != null) {
      data['userWish'] = userWish!.toJson();
    }
    if (userWishlistImages != null) {
      data['user_wishlist_images'] =
          userWishlistImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserWish {
  String? createdAt;
  String? updatedAt;
  int? anonymous;
  int? status;
  dynamic committedAt;
  dynamic purchasedAt;
  dynamic grantedAt;
  int? id;
  String? productName;
  String? desiredCountryId;
  String? productLink;
  String? wishlistCategoryId;
  String? quantity;
  String? productDescription;
  String? addressId;
  String? committedBy;
  int? verified_traveler_counts;

  UserWish({
    this.createdAt,
    this.updatedAt,
    this.anonymous,
    this.status,
    this.committedAt,
    this.purchasedAt,
    this.grantedAt,
    this.id,
    this.productName,
    this.desiredCountryId,
    this.productLink,
    this.wishlistCategoryId,
    this.quantity,
    this.productDescription,
    this.addressId,
    this.committedBy,
    this.verified_traveler_counts,
  });

  UserWish.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    anonymous = json['anonymous'];
    status = json['status'];
    committedAt = json['committed_at'];
    purchasedAt = json['purchased_at'];
    grantedAt = json['granted_at'];
    id = json['id'];
    productName = json['product_name'];
    desiredCountryId = json['desired_country_id'];
    productLink = json['product_link'];
    wishlistCategoryId = json['wishlist_category_id'];
    quantity = json['quantity'];
    productDescription = json['product_description'];
    addressId = json['address_id'];
    committedBy = json['committed_by'];
    verified_traveler_counts = json['verified_traveler_counts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['anonymous'] = anonymous;
    data['status'] = status;
    data['committed_at'] = committedAt;
    data['purchased_at'] = purchasedAt;
    data['granted_at'] = grantedAt;
    data['id'] = id;
    data['product_name'] = productName;
    data['desired_country_id'] = desiredCountryId;
    data['product_link'] = productLink;
    data['wishlist_category_id'] = wishlistCategoryId;
    data['quantity'] = quantity;
    data['product_description'] = productDescription;
    data['address_id'] = addressId;
    data['committed_by'] = committedBy;
    data['verified_traveler_counts'] = verified_traveler_counts;
    return data;
  }
}

class UserWishlistImages {
  String? updatedAt;
  int? id;
  String? fileName;
  int? wishlistId;
  String? createdAt;

  UserWishlistImages(
      {this.updatedAt,
      this.id,
      this.fileName,
      this.wishlistId,
      this.createdAt});

  UserWishlistImages.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updated_at'];
    id = json['id'];
    fileName = json['file_name'];
    wishlistId = json['wishlist_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['updated_at'] = updatedAt;
    data['id'] = id;
    data['file_name'] = fileName;
    data['wishlist_id'] = wishlistId;
    data['created_at'] = createdAt;
    return data;
  }
}
