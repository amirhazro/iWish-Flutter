import 'package:iwish_flutter/models/base_response_model.dart';

class DeleteWishResponseModel extends BaseResponseModel {
  Data? data;

  DeleteWishResponseModel(
      {String? status,
      int? statusCode,
      String? message,
      this.data,
      dynamic error})
      : super(
          error: error,
          status: status,
          statusCode: statusCode,
        );

  DeleteWishResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? deletedAt;

  Data(
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
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
