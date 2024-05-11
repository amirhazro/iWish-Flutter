import 'package:iwish_flutter/models/base_response_model.dart';

import '../../../models/user_model.dart';

class WishDetailResponseModel extends BaseResponseModel {
  Data? data;

  WishDetailResponseModel({
    String? status,
    int? statusCode,
    String? message,
    this.data,
    dynamic error,
  }) : super(
          error: error,
          status: status,
          statusCode: statusCode,
          message: message,
        );

  WishDetailResponseModel.fromJson(Map<String, dynamic> json) {
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
  Wish? wish;

  Data({this.wish});

  Data.fromJson(Map<String, dynamic> json) {
    wish = json['wish'] != null ? Wish.fromJson(json['wish']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wish != null) {
      data['wish'] = wish!.toJson();
    }
    return data;
  }
}

class Wish {
  int? id;
  int? wishlistCategoryId;
  int? desiredCountryId;
  int? addressId;
  int? quantity;
  int? committedBy;
  dynamic referenceWishId;
  int? wishUsedCount;
  int? anonymous;
  String? productName;
  String? productLink;
  String? productDescription;
  int? status;
  String? deliveryStatus;
  int? verifiedTravelerCounts;
  dynamic committedAt;
  dynamic purchasedAt;
  dynamic grantedAt;
  String? updatedAt;
  String? createdAt;
  dynamic deletedAt;
  User? user;
  CountriesMaster? countriesMaster;
  List<UserWishlistImages>? userWishlistImages;

  Wish(
      {this.id,
      this.wishlistCategoryId,
      this.desiredCountryId,
      this.addressId,
      this.quantity,
      this.committedBy,
      this.referenceWishId,
      this.wishUsedCount,
      this.anonymous,
      this.productName,
      this.productLink,
      this.productDescription,
      this.status,
      this.deliveryStatus,
      this.verifiedTravelerCounts,
      this.committedAt,
      this.purchasedAt,
      this.grantedAt,
      this.updatedAt,
      this.createdAt,
      this.deletedAt,
      this.user,
      this.countriesMaster,
      this.userWishlistImages});

  Wish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wishlistCategoryId = json['wishlist_category_id'];
    desiredCountryId = json['desired_country_id'];
    addressId = json['address_id'];
    quantity = json['quantity'];
    committedBy = json['committed_by'];
    referenceWishId = json['reference_wish_id'];
    wishUsedCount = json['wish_used_count'];
    anonymous = json['anonymous'];
    productName = json['product_name'];
    productLink = json['product_link'];
    productDescription = json['product_description'];
    status = json['status'];
    deliveryStatus = json['delivery_status'];
    verifiedTravelerCounts = json['verified_traveler_counts'];
    committedAt = json['committed_at'];
    purchasedAt = json['purchased_at'];
    grantedAt = json['granted_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    deletedAt = json['deletedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    countriesMaster = json['countries_master'] != null
        ? CountriesMaster.fromJson(json['countries_master'])
        : null;
    if (json['user_wishlist_images'] != null) {
      userWishlistImages = <UserWishlistImages>[];
      json['user_wishlist_images'].forEach((v) {
        userWishlistImages!.add(UserWishlistImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wishlist_category_id'] = wishlistCategoryId;
    data['desired_country_id'] = desiredCountryId;
    data['address_id'] = addressId;
    data['quantity'] = quantity;
    data['committed_by'] = committedBy;
    data['reference_wish_id'] = referenceWishId;
    data['wish_used_count'] = wishUsedCount;
    data['anonymous'] = anonymous;
    data['product_name'] = productName;
    data['product_link'] = productLink;
    data['product_description'] = productDescription;
    data['status'] = status;
    data['delivery_status'] = deliveryStatus;
    data['verified_traveler_counts'] = verifiedTravelerCounts;
    data['committed_at'] = committedAt;
    data['purchased_at'] = purchasedAt;
    data['granted_at'] = grantedAt;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['deletedAt'] = deletedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (countriesMaster != null) {
      data['countries_master'] = countriesMaster!.toJson();
    }
    if (userWishlistImages != null) {
      data['user_wishlist_images'] =
          userWishlistImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountriesMaster {
  int? id;
  String? name;
  String? iso3;
  String? numericCode;
  String? iso2;
  String? phonecode;
  String? capital;
  String? currency;
  String? currencyName;
  String? currencySymbol;
  String? tld;
  String? native;
  String? region;
  String? subregion;
  String? timezones;
  String? translations;
  String? latitude;
  String? longitude;
  String? emoji;
  String? emojiU;
  String? createdAt;
  String? updatedAt;
  bool? flag;
  String? wikiDataId;

  CountriesMaster(
      {this.id,
      this.name,
      this.iso3,
      this.numericCode,
      this.iso2,
      this.phonecode,
      this.capital,
      this.currency,
      this.currencyName,
      this.currencySymbol,
      this.tld,
      this.native,
      this.region,
      this.subregion,
      this.timezones,
      this.translations,
      this.latitude,
      this.longitude,
      this.emoji,
      this.emojiU,
      this.createdAt,
      this.updatedAt,
      this.flag,
      this.wikiDataId});

  CountriesMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iso3 = json['iso3'];
    numericCode = json['numeric_code'];
    iso2 = json['iso2'];
    phonecode = json['phonecode'];
    capital = json['capital'];
    currency = json['currency'];
    currencyName = json['currency_name'];
    currencySymbol = json['currency_symbol'];
    tld = json['tld'];
    native = json['native'];
    region = json['region'];
    subregion = json['subregion'];
    timezones = json['timezones'];
    translations = json['translations'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    emoji = json['emoji'];
    emojiU = json['emoji_u'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    flag = json['flag'];
    wikiDataId = json['wiki_data_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iso3'] = iso3;
    data['numeric_code'] = numericCode;
    data['iso2'] = iso2;
    data['phonecode'] = phonecode;
    data['capital'] = capital;
    data['currency'] = currency;
    data['currency_name'] = currencyName;
    data['currency_symbol'] = currencySymbol;
    data['tld'] = tld;
    data['native'] = native;
    data['region'] = region;
    data['subregion'] = subregion;
    data['timezones'] = timezones;
    data['translations'] = translations;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['emoji'] = emoji;
    data['emoji_u'] = emojiU;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['flag'] = flag;
    data['wiki_data_id'] = wikiDataId;
    return data;
  }
}

class UserWishlistImages {
  int? id;
  int? wishlistId;
  String? fileName;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  UserWishlistImages(
      {this.id,
      this.wishlistId,
      this.fileName,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  UserWishlistImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wishlistId = json['wishlist_id'];
    fileName = json['file_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wishlist_id'] = wishlistId;
    data['file_name'] = fileName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deletedAt'] = deletedAt;
    return data;
  }
}
