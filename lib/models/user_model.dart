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
  int? isEnabled;
  dynamic additionalnumber;
  dynamic countryid;
  dynamic country;
  dynamic referralCode;
  int? isDeleted;
  dynamic deletedAt;

  User({
    this.id,
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
    this.referralCode,
    this.isDeleted,
    this.deletedAt,
  });

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
    isEnabled = json['is_enabled'];
    additionalnumber = json['additionalnumber'];
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
    data['is_enabled'] = isEnabled;
    data['additionalnumber'] = additionalnumber;
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
