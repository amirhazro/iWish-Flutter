import 'package:iwish_flutter/models/base_response_model.dart';

class OfferResponseModel extends BaseResponseModel {
  Data? data;

  OfferResponseModel(
      {super.status, super.statusCode, super.message, this.data, super.error});

  OfferResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Offers>? offers;
  Pagination? pagination;

  Data({this.offers, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(Offers.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Offers {
  int? id;
  int? userWishlistId;
  int? offeredBy;
  int? offeredTo;
  int? tripId;
  String? currencyCode;
  String? purchaseFrom;
  double? productPrice;
  double? vatPrice;
  double? shippingFee;
  double? iwishFee;
  double? travelerFee;
  int? quantity;
  double? totalUnitPrice;
  double? totalPrice;
  String? deliveryType;
  String? offerStatus;
  dynamic reasonDeclined;
  dynamic paymentMethod;
  dynamic courierService;
  dynamic trackingNumber;
  dynamic newimagepath;
  int? shippingFrom;
  dynamic shippingTo;
  dynamic weight;
  dynamic height;
  dynamic width;
  int? expiry;
  String? expiryAt;
  dynamic expectedDeliverydate;
  UserWishlist? userWishlist;
  Traveler? traveler;
  Trip? trip;

  Offers(
      {this.id,
      this.userWishlistId,
      this.offeredBy,
      this.offeredTo,
      this.tripId,
      this.currencyCode,
      this.purchaseFrom,
      this.productPrice,
      this.vatPrice,
      this.shippingFee,
      this.iwishFee,
      this.travelerFee,
      this.quantity,
      this.totalUnitPrice,
      this.totalPrice,
      this.deliveryType,
      this.offerStatus,
      this.reasonDeclined,
      this.paymentMethod,
      this.courierService,
      this.trackingNumber,
      this.newimagepath,
      this.shippingFrom,
      this.shippingTo,
      this.weight,
      this.height,
      this.width,
      this.expiry,
      this.expiryAt,
      this.expectedDeliverydate,
      this.userWishlist,
      this.traveler,
      this.trip});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userWishlistId = json['user_wishlist_id'];
    offeredBy = json['offered_by'];
    offeredTo = json['offered_to'];
    tripId = json['trip_id'];
    currencyCode = json['currency_code'];
    purchaseFrom = json['purchase_from'];
    if (json['product_price'] is int) {
      productPrice = json['product_price'].toDouble();
    } else {
      productPrice = json['product_price'];
    }
    if (json['vat_price'] is int) {
      vatPrice = json['vat_price'].toDouble();
    } else {
      vatPrice = json['vat_price'];
    }
    if (json['iwish_fee'] is int) {
      iwishFee = json['iwish_fee'].toDouble();
    } else {
      iwishFee = json['iwish_fee'];
    }
    if (json['shipping_fee'] is int) {
      shippingFee = json['shipping_fee'].toDouble();
    } else {
      shippingFee = json['shipping_fee'];
    }
    if (json['traveler_fee'] is int) {
      travelerFee = json['traveler_fee'].toDouble();
    } else {
      travelerFee = json['traveler_fee'];
    }
    if (json['total_price'] is int) {
      totalPrice = json['total_price'].toDouble();
    } else {
      totalPrice = json['total_price'];
    }
    if (json['total_unit_price'] is int) {
      totalUnitPrice = json['total_unit_price'].toDouble();
    } else {
      totalUnitPrice = json['total_unit_price'];
    }
    quantity = json['quantity'];
    deliveryType = json['delivery_type'];
    offerStatus = json['offer_status'];
    reasonDeclined = json['reason_declined'];
    paymentMethod = json['payment_method'];
    courierService = json['courier_service'];
    trackingNumber = json['tracking_number'];
    newimagepath = json['newimagepath'];
    shippingFrom = json['shipping_from'];
    shippingTo = json['shipping_to'];
    weight = json['weight'];
    height = json['height'];
    width = json['width'];
    expiry = json['expiry'];
    expiryAt = json['expiry_at'];
    expectedDeliverydate = json['expected_deliverydate'];
    userWishlist = json['user_wishlist'] != null
        ? UserWishlist.fromJson(json['user_wishlist'])
        : null;
    traveler =
        json['traveler'] != null ? Traveler.fromJson(json['traveler']) : null;
    trip = json['trip'] != null ? Trip.fromJson(json['trip']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_wishlist_id'] = userWishlistId;
    data['offered_by'] = offeredBy;
    data['offered_to'] = offeredTo;
    data['trip_id'] = tripId;
    data['currency_code'] = currencyCode;
    data['purchase_from'] = purchaseFrom;
    data['product_price'] = productPrice;
    data['vat_price'] = vatPrice;
    data['shipping_fee'] = shippingFee;
    data['iwish_fee'] = iwishFee;
    data['traveler_fee'] = travelerFee;
    data['quantity'] = quantity;
    data['total_unit_price'] = totalUnitPrice;
    data['total_price'] = totalPrice;
    data['delivery_type'] = deliveryType;
    data['offer_status'] = offerStatus;
    data['reason_declined'] = reasonDeclined;
    data['payment_method'] = paymentMethod;
    data['courier_service'] = courierService;
    data['tracking_number'] = trackingNumber;
    data['newimagepath'] = newimagepath;
    data['shipping_from'] = shippingFrom;
    data['shipping_to'] = shippingTo;
    data['weight'] = weight;
    data['height'] = height;
    data['width'] = width;
    data['expiry'] = expiry;
    data['expiry_at'] = expiryAt;
    data['expected_deliverydate'] = expectedDeliverydate;
    if (userWishlist != null) {
      data['user_wishlist'] = userWishlist!.toJson();
    }
    if (traveler != null) {
      data['traveler'] = traveler!.toJson();
    }
    if (trip != null) {
      data['trip'] = trip!.toJson();
    }
    return data;
  }
}

class UserWishlist {
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
  dynamic verifiedTravelerCounts;
  dynamic committedAt;
  dynamic purchasedAt;
  dynamic grantedAt;
  String? updatedAt;
  String? createdAt;
  List<UserWishlistImages>? userWishlistImages;

  UserWishlist(
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
      this.userWishlistImages});

  UserWishlist.fromJson(Map<String, dynamic> json) {
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
    if (userWishlistImages != null) {
      data['user_wishlist_images'] =
          userWishlistImages!.map((v) => v.toJson()).toList();
    }
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

class Traveler {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic username;
  dynamic genderid;
  dynamic dateofbirth;
  dynamic picture;
  dynamic about;
  String? contactnumber;
  dynamic identitytype;
  dynamic idnumber;
  dynamic indentitypicture;
  bool? onbpostrequest;
  bool? onbposttrip;
  bool? isverified;
  int? emailverificationcode;
  int? numberverificationcode;
  String? numberCodeExpiry;
  String? emailCodeExpiry;
  String? createdAt;
  String? updatedAt;
  bool? emailVerified;
  bool? contactnumberVerified;
  dynamic fbid;
  int? followerscount;
  int? followingcount;
  dynamic googleid;
  dynamic appleid;
  int? deliveryRate;
  int? userRating;
  int? royaltyPoints;
  int? longitude;
  int? latitude;
  int? isEnabled;
  dynamic additionalnumber;
  dynamic countryid;
  dynamic country;
  String? onlineStatus;
  dynamic referralCode;
  int? isDeleted;

  Traveler(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.username,
      this.genderid,
      this.dateofbirth,
      this.picture,
      this.about,
      this.contactnumber,
      this.identitytype,
      this.idnumber,
      this.indentitypicture,
      this.onbpostrequest,
      this.onbposttrip,
      this.isverified,
      this.emailverificationcode,
      this.numberverificationcode,
      this.numberCodeExpiry,
      this.emailCodeExpiry,
      this.createdAt,
      this.updatedAt,
      this.emailVerified,
      this.contactnumberVerified,
      this.fbid,
      this.followerscount,
      this.followingcount,
      this.googleid,
      this.appleid,
      this.deliveryRate,
      this.userRating,
      this.royaltyPoints,
      this.longitude,
      this.latitude,
      this.isEnabled,
      this.additionalnumber,
      this.countryid,
      this.country,
      this.onlineStatus,
      this.referralCode,
      this.isDeleted});

  Traveler.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    username = json['username'];
    genderid = json['genderid'];
    dateofbirth = json['dateofbirth'];
    picture = json['picture'];
    about = json['about'];
    contactnumber = json['contactnumber'];
    identitytype = json['identitytype'];
    idnumber = json['idnumber'];
    indentitypicture = json['indentitypicture'];
    onbpostrequest = json['onbpostrequest'];
    onbposttrip = json['onbposttrip'];
    isverified = json['isverified'];
    emailverificationcode = json['emailverificationcode'];
    numberverificationcode = json['numberverificationcode'];
    numberCodeExpiry = json['number_code_expiry'];
    emailCodeExpiry = json['email_code_expiry'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    emailVerified = json['email_verified'];
    contactnumberVerified = json['contactnumber_verified'];
    fbid = json['fbid'];
    followerscount = json['followerscount'];
    followingcount = json['followingcount'];
    googleid = json['googleid'];
    appleid = json['appleid'];
    deliveryRate = json['delivery_rate'];
    userRating = json['user_rating'];
    royaltyPoints = json['royalty_points'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    isEnabled = json['is_enabled'];
    additionalnumber = json['additionalnumber'];
    countryid = json['countryid'];
    country = json['country'];
    onlineStatus = json['online_status'];
    referralCode = json['referral_code'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['username'] = username;
    data['genderid'] = genderid;
    data['dateofbirth'] = dateofbirth;
    data['picture'] = picture;
    data['about'] = about;
    data['contactnumber'] = contactnumber;
    data['identitytype'] = identitytype;
    data['idnumber'] = idnumber;
    data['indentitypicture'] = indentitypicture;
    data['onbpostrequest'] = onbpostrequest;
    data['onbposttrip'] = onbposttrip;
    data['isverified'] = isverified;
    data['emailverificationcode'] = emailverificationcode;
    data['numberverificationcode'] = numberverificationcode;
    data['number_code_expiry'] = numberCodeExpiry;
    data['email_code_expiry'] = emailCodeExpiry;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['email_verified'] = emailVerified;
    data['contactnumber_verified'] = contactnumberVerified;
    data['fbid'] = fbid;
    data['followerscount'] = followerscount;
    data['followingcount'] = followingcount;
    data['googleid'] = googleid;
    data['appleid'] = appleid;
    data['delivery_rate'] = deliveryRate;
    data['user_rating'] = userRating;
    data['royalty_points'] = royaltyPoints;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['is_enabled'] = isEnabled;
    data['additionalnumber'] = additionalnumber;
    data['countryid'] = countryid;
    data['country'] = country;
    data['online_status'] = onlineStatus;
    data['referral_code'] = referralCode;
    data['is_deleted'] = isDeleted;
    return data;
  }
}

class Trip {
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
  dynamic returnDate;
  String? tripStatus;
  String? createdAt;
  String? updatedAt;
  FromCity? fromCity;
  FromCity? toCity;

  Trip(
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

  Trip.fromJson(Map<String, dynamic> json) {
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
  CountriesMaster? countriesMaster;

  FromCity({this.id, this.name, this.countriesMaster});

  FromCity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countriesMaster = json['countries_master'] != null
        ? CountriesMaster.fromJson(json['countries_master'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (countriesMaster != null) {
      data['countries_master'] = countriesMaster!.toJson();
    }
    return data;
  }
}

class CountriesMaster {
  int? id;
  String? name;
  String? iso3;

  CountriesMaster({this.id, this.name, this.iso3});

  CountriesMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iso3 = json['iso3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iso3'] = iso3;
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
