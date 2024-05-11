import 'package:iwish_flutter/models/base_response_model.dart';

class CompleteProfileResponseModel extends BaseResponseModel {
  Data? data;

  CompleteProfileResponseModel({
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

  CompleteProfileResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
