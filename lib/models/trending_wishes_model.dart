class TrendingWishes {
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
  dynamic committedAt;
  dynamic purchasedAt;
  dynamic grantedAt;
  String? updatedAt;
  String? createdAt;
  dynamic deletedAt;
  List<UserWishlistImages>? userWishlistImages;
  User? user;
  CountriesMaster? countriesMaster;

  TrendingWishes({
    this.id,
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
    this.committedAt,
    this.purchasedAt,
    this.grantedAt,
    this.updatedAt,
    this.createdAt,
    this.deletedAt,
    this.user,
    this.userWishlistImages,
    this.countriesMaster,
  });

  TrendingWishes.fromJson(Map<String, dynamic> json) {
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
    committedAt = json['committed_at'];
    purchasedAt = json['purchased_at'];
    grantedAt = json['granted_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    deletedAt = json['deletedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['user_wishlist_images'] != null) {
      userWishlistImages = <UserWishlistImages>[];
      json['user_wishlist_images'].forEach((v) {
        userWishlistImages!.add(UserWishlistImages.fromJson(v));
      });
    }
    countriesMaster = json['countries_master'] != null
        ? CountriesMaster.fromJson(json['countries_master'])
        : null;
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
    data['committed_at'] = committedAt;
    data['purchased_at'] = purchasedAt;
    data['granted_at'] = grantedAt;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['deletedAt'] = deletedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (userWishlistImages != null) {
      data['user_wishlist_images'] =
          userWishlistImages!.map((v) => v.toJson()).toList();
    }
    if (countriesMaster != null) {
      data['countries_master'] = countriesMaster!.toJson();
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
  dynamic firstLanguage;
  dynamic secondLanguage;
  int? isEnabled;
  dynamic buildingnumber;
  dynamic unitnumber;
  dynamic streetname;
  dynamic district;
  dynamic zipcode;
  dynamic additionalnumber;
  dynamic region;
  dynamic countryid;
  dynamic country;
  dynamic referralCode;
  int? isDeleted;
  dynamic deletedAt;

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
      this.firstLanguage,
      this.secondLanguage,
      this.isEnabled,
      this.buildingnumber,
      this.unitnumber,
      this.streetname,
      this.district,
      this.zipcode,
      this.additionalnumber,
      this.region,
      this.countryid,
      this.country,
      this.referralCode,
      this.isDeleted,
      this.deletedAt});

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
    firstLanguage = json['first_language'];
    secondLanguage = json['second_language'];
    isEnabled = json['is_enabled'];
    buildingnumber = json['buildingnumber'];
    unitnumber = json['unitnumber'];
    streetname = json['streetname'];
    district = json['district'];
    zipcode = json['zipcode'];
    additionalnumber = json['additionalnumber'];
    region = json['region'];
    countryid = json['countryid'];
    country = json['country'];
    referralCode = json['referral_code'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deletedAt'];
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
    data['first_language'] = firstLanguage;
    data['second_language'] = secondLanguage;
    data['is_enabled'] = isEnabled;
    data['buildingnumber'] = buildingnumber;
    data['unitnumber'] = unitnumber;
    data['streetname'] = streetname;
    data['district'] = district;
    data['zipcode'] = zipcode;
    data['additionalnumber'] = additionalnumber;
    data['region'] = region;
    data['countryid'] = countryid;
    data['country'] = country;
    data['referral_code'] = referralCode;
    data['is_deleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
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
