import 'package:iwish_flutter/models/base_response_model.dart';

class ChatMessageResponseModel extends BaseResponseModel {
  Data? data;

  ChatMessageResponseModel(
      {super.status, super.statusCode, super.message, this.data, super.error});

  ChatMessageResponseModel.fromJson(Map<String, dynamic> json) {
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
  EndUser? endUser;
  List<Messages>? messages;
  Pagination? pagination;

  Data({this.endUser, this.messages, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    endUser =
        json['endUser'] != null ? EndUser.fromJson(json['endUser']) : null;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (endUser != null) {
      data['endUser'] = endUser!.toJson();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class EndUser {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  Null username;
  Null genderid;
  Null dateofbirth;
  String? picture;
  Null about;
  String? contactnumber;
  Null identitytype;
  Null idnumber;
  Null indentitypicture;
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
  Null fbid;
  int? followerscount;
  int? followingcount;
  Null googleid;
  Null appleid;
  int? deliveryRate;
  int? userRating;
  int? royaltyPoints;
  int? longitude;
  int? latitude;
  int? isEnabled;
  Null additionalnumber;
  Null countryid;
  Null country;
  String? onlineStatus;
  Null referralCode;
  int? isDeleted;

  EndUser(
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

  EndUser.fromJson(Map<String, dynamic> json) {
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

class Messages {
  int? id;
  int? fromId;
  int? toId;
  String? threadId;
  dynamic referenceOf;
  String? isDelete;
  String? deletedForAll;
  String? messageContent;
  String? messageType;
  Null conversationType;
  String? status;
  dynamic senderReaction;
  dynamic receiverReaction;
  String? createdAt;
  String? updatedAt;
  List<MessagesMedia>? messagesMedia;

  Messages(
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
      this.messagesMedia});

  Messages.fromJson(Map<String, dynamic> json) {
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
    if (json['messages_media'] != null) {
      messagesMedia = <MessagesMedia>[];
      json['messages_media'].forEach((v) {
        messagesMedia!.add(MessagesMedia.fromJson(v));
      });
    }
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
    if (messagesMedia != null) {
      data['messages_media'] = messagesMedia!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessagesMedia {
  int? id;
  int? fromId;
  int? toId;
  int? messageId;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;

  MessagesMedia(
      {this.id,
      this.fromId,
      this.toId,
      this.messageId,
      this.name,
      this.type,
      this.createdAt,
      this.updatedAt});

  MessagesMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    messageId = json['message_id'];
    name = json['name'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_id'] = fromId;
    data['to_id'] = toId;
    data['message_id'] = messageId;
    data['name'] = name;
    data['type'] = type;
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
