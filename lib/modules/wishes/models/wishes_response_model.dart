import 'package:iwish_flutter/models/base_response_model.dart';

class WishesResponseModel extends BaseResponseModel {
  Data? data;

  WishesResponseModel(
      {super.status, super.statusCode, super.message, this.data, super.error});

  WishesResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Wishes>? wishes;
  Pagination? pagination;

  Data({this.wishes, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (wishes != null) {
      data['wishes'] = wishes!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
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
  dynamic referenceWishId;
  int? wishUsedCount;
  String? productName;
  String? productLink;
  int? status;
  String? deliveryStatus;
  int? verifiedTravelerCounts;
  int? offersCount;
  String? reviewByWisher;
  String? reviewByTraveler;
  User? user;
  List<Offers>? offers;
  dynamic ratingReview;
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
      this.productName,
      this.productLink,
      this.status,
      this.deliveryStatus,
      this.verifiedTravelerCounts,
      this.offersCount,
      this.user,
      this.offers,
      this.ratingReview,
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
    productName = json['product_name'];
    productLink = json['product_link'];
    status = json['status'];
    reviewByWisher = json['review_by_wisher'];
    reviewByTraveler = json['review_by_traveler'];
    deliveryStatus = json['delivery_status'];
    verifiedTravelerCounts = json['verified_traveler_counts'];
    offersCount = json['offers_count'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(Offers.fromJson(v));
      });
    }
    ratingReview = json['rating_review'];
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
    data['product_name'] = productName;
    data['product_link'] = productLink;
    data['review_by_wisher'] = reviewByWisher;
    data['review_by_traveler'] = reviewByTraveler;
    data['status'] = status;
    data['delivery_status'] = deliveryStatus;
    data['verified_traveler_counts'] = verifiedTravelerCounts;
    data['offers_count'] = offersCount;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    data['rating_review'] = ratingReview;
    if (userWishlistImages != null) {
      data['user_wishlist_images'] =
          userWishlistImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic username;
  dynamic genderid;
  dynamic dateofbirth;
  String? picture;
  dynamic about;
  String? contactnumber;
  dynamic identitytype;
  dynamic idnumber;
  dynamic indentitypicture;
  bool? onbpostrequest;
  bool? onbposttrip;
  bool? isverified;
  String? identityVerification;
  String? bankAccount;
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

  User(
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
      this.identityVerification,
      this.bankAccount,
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

  User.fromJson(Map<String, dynamic> json) {
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
    identityVerification = json['identity_verification'];
    bankAccount = json['bank_account'];
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
    data['identity_verification'] = identityVerification;
    data['bank_account'] = bankAccount;
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
      this.expectedDeliverydate});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userWishlistId = json['user_wishlist_id'];
    offeredBy = json['offered_by'];
    offeredTo = json['offered_to'];
    tripId = json['trip_id'];
    currencyCode = json['currency_code'];
    purchaseFrom = json['purchase_from'];
    productPrice = json['product_price'].toDouble();
    vatPrice = json['vat_price'].toDouble();
    shippingFee = json['shipping_fee'].toDouble();
    iwishFee = json['iwish_fee'].toDouble();
    travelerFee = json['traveler_fee'].toDouble();
    quantity = json['quantity'];
    totalUnitPrice = json['total_unit_price'].toDouble();
    totalPrice = json['total_price'].toDouble();
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
