import 'package:iwish_flutter/models/base_response_model.dart';

class ChatListResponseModel extends BaseResponseModel {
  Data? data;

  ChatListResponseModel(
      {super.status, super.statusCode, super.message, this.data, super.error});

  ChatListResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Conversations>? conversations;
  Pagination? pagination;

  Data({this.conversations, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['conversations'] != null) {
      conversations = <Conversations>[];
      json['conversations'].forEach((v) {
        conversations!.add(Conversations.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (conversations != null) {
      data['conversations'] = conversations!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Conversations {
  OtherUser? otherUser;
  LastMessage? lastMessage;

  Conversations({this.otherUser, this.lastMessage});

  Conversations.fromJson(Map<String, dynamic> json) {
    otherUser = json['otherUser'] != null
        ? OtherUser.fromJson(json['otherUser'])
        : null;
    lastMessage = json['lastMessage'] != null
        ? LastMessage.fromJson(json['lastMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (otherUser != null) {
      data['otherUser'] = otherUser!.toJson();
    }
    if (lastMessage != null) {
      data['lastMessage'] = lastMessage!.toJson();
    }
    return data;
  }
}

class OtherUser {
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

  OtherUser(
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

  OtherUser.fromJson(Map<String, dynamic> json) {
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

class LastMessage {
  int? id;
  int? fromId;
  int? toId;
  String? threadId;
  dynamic referenceOf;
  String? isDelete;
  String? deletedForAll;
  String? messageContent;
  String? messageType;
  dynamic conversationType;
  String? status;
  dynamic senderReaction;
  dynamic receiverReaction;
  String? createdAt;
  String? updatedAt;
  int? unread;

  LastMessage(
      {this.id,
      this.fromId,
      this.toId,
      this.threadId,
      this.referenceOf,
      this.isDelete,
      this.deletedForAll,
      this.messageContent,
      this.messageType,
      this.conversationType,
      this.status,
      this.senderReaction,
      this.receiverReaction,
      this.createdAt,
      this.updatedAt,
      this.unread});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    threadId = json['thread_id'];
    referenceOf = json['reference_of'];
    isDelete = json['is_delete'];
    deletedForAll = json['deleted_for_all'];
    messageContent = json['message_content'];
    messageType = json['message_type'];
    conversationType = json['conversation_type'];
    status = json['status'];
    senderReaction = json['sender_reaction'];
    receiverReaction = json['receiver_reaction'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    unread = json['unread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_id'] = fromId;
    data['to_id'] = toId;
    data['thread_id'] = threadId;
    data['reference_of'] = referenceOf;
    data['is_delete'] = isDelete;
    data['deleted_for_all'] = deletedForAll;
    data['message_content'] = messageContent;
    data['message_type'] = messageType;
    data['conversation_type'] = conversationType;
    data['status'] = status;
    data['sender_reaction'] = senderReaction;
    data['receiver_reaction'] = receiverReaction;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['unread'] = unread;
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
