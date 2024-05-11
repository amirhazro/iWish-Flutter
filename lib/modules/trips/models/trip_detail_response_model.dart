import 'package:iwish_flutter/models/base_response_model.dart';

class TripDetailResponseModel extends BaseResponseModel {
  Data? data;

  TripDetailResponseModel(
      {super.status, super.statusCode, super.message, this.data, super.error});

  TripDetailResponseModel.fromJson(Map<String, dynamic> json) {
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
  TripDetails? tripDetails;
  List<Wishes>? wishes;
  Pagination? pagination;

  Data({this.tripDetails, this.wishes, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    tripDetails = json['tripDetails'] != null
        ? TripDetails.fromJson(json['tripDetails'])
        : null;
    if (json['wishes'] != null) {
      wishes = <Wishes>[];
      json['wishes'].forEach((v) {
        wishes!.add(Wishes.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tripDetails != null) {
      data['tripDetails'] = tripDetails!.toJson();
    }
    if (wishes != null) {
      data['wishes'] = wishes!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class TripDetails {
  int? id;
  String? tripType;
  int? userId;
  dynamic residentCityid;
  dynamic residentCountryid;
  int? fromCityid;
  int? fromCountryid;
  int? toCityid;
  int? toCountryid;
  int? isResident;
  String? departureDate;
  String? returnDate;
  String? tripStatus;
  String? createdAt;
  String? updatedAt;
  FromCity? fromCity;
  FromCity? toCity;

  TripDetails(
      {this.id,
      this.tripType,
      this.userId,
      this.residentCityid,
      this.residentCountryid,
      this.fromCityid,
      this.fromCountryid,
      this.toCityid,
      this.toCountryid,
      this.isResident,
      this.departureDate,
      this.returnDate,
      this.tripStatus,
      this.createdAt,
      this.updatedAt,
      this.fromCity,
      this.toCity});

  TripDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tripType = json['trip_type'];
    userId = json['user_id'];
    residentCityid = json['resident_cityid'];
    residentCountryid = json['resident_countryid'];
    fromCityid = json['from_cityid'];
    fromCountryid = json['from_countryid'];
    toCityid = json['to_cityid'];
    toCountryid = json['to_countryid'];
    isResident = json['is_resident'];
    departureDate = json['departure_date'];
    returnDate = json['return_date'];
    tripStatus = json['trip_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fromCity =
        json['from_city'] != null ? FromCity.fromJson(json['from_city']) : null;
    toCity =
        json['to_city'] != null ? FromCity.fromJson(json['to_city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trip_type'] = tripType;
    data['user_id'] = userId;
    data['resident_cityid'] = residentCityid;
    data['resident_countryid'] = residentCountryid;
    data['from_cityid'] = fromCityid;
    data['from_countryid'] = fromCountryid;
    data['to_cityid'] = toCityid;
    data['to_countryid'] = toCountryid;
    data['is_resident'] = isResident;
    data['departure_date'] = departureDate;
    data['return_date'] = returnDate;
    data['trip_status'] = tripStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (fromCity != null) {
      data['from_city'] = fromCity!.toJson();
    }
    if (toCity != null) {
      data['to_city'] = toCity!.toJson();
    }
    return data;
  }
}

class FromCity {
  int? id;
  String? name;
  int? stateId;
  String? stateCode;
  int? countryId;
  String? countryCode;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  bool? flag;
  String? wikiDataId;

  FromCity(
      {this.id,
      this.name,
      this.stateId,
      this.stateCode,
      this.countryId,
      this.countryCode,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.flag,
      this.wikiDataId});

  FromCity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
    stateCode = json['state_code'];
    countryId = json['country_id'];
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    flag = json['flag'];
    wikiDataId = json['wiki_data_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['state_id'] = stateId;
    data['state_code'] = stateCode;
    data['country_id'] = countryId;
    data['country_code'] = countryCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['flag'] = flag;
    data['wiki_data_id'] = wikiDataId;
    return data;
  }
}

class Wishes {
  int? id;
  int? wishlistCategoryId;
  int? desiredCountryId;
  int? addressId;
  int? quantity;
  int? committedBy;
  int? referenceWishId;
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
  WishAddress? wishAddress;
  CountriesMaster? countriesMaster;
  List<UserWishlistImages>? userWishlistImages;

  Wishes(
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
      this.wishAddress,
      this.countriesMaster,
      this.userWishlistImages});

  Wishes.fromJson(Map<String, dynamic> json) {
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
    wishAddress = json['wish_address'] != null
        ? WishAddress.fromJson(json['wish_address'])
        : null;
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
    if (wishAddress != null) {
      data['wish_address'] = wishAddress!.toJson();
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

class WishAddress {
  int? id;
  int? userId;
  String? addressName;
  String? streetAddress;
  int? cityId;
  String? state;
  String? zipCode;
  String? setAs;
  String? createdAt;
  String? updatedAt;
  FromCity? city;

  WishAddress(
      {this.id,
      this.userId,
      this.addressName,
      this.streetAddress,
      this.cityId,
      this.state,
      this.zipCode,
      this.setAs,
      this.createdAt,
      this.updatedAt,
      this.city});

  WishAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressName = json['address_name'];
    streetAddress = json['street_address'];
    cityId = json['city_id'];
    state = json['state'];
    zipCode = json['zip_code'];
    setAs = json['set_as'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    city = json['city'] != null ? FromCity.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['address_name'] = addressName;
    data['street_address'] = streetAddress;
    data['city_id'] = cityId;
    data['state'] = state;
    data['zip_code'] = zipCode;
    data['set_as'] = setAs;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (city != null) {
      data['city'] = city!.toJson();
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

  UserWishlistImages(
      {this.id,
      this.wishlistId,
      this.fileName,
      this.createdAt,
      this.updatedAt});

  UserWishlistImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wishlistId = json['wishlist_id'];
    fileName = json['file_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wishlist_id'] = wishlistId;
    data['file_name'] = fileName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
