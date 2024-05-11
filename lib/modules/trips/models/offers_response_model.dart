import 'package:iwish_flutter/models/base_response_model.dart';
import 'package:iwish_flutter/modules/wishes/models/wishes_response_model.dart';

class OffersResponseModel extends BaseResponseModel {
  Data? data;

  OffersResponseModel(
      {super.status, super.statusCode, super.message, this.data, super.error});

  OffersResponseModel.fromJson(Map<String, dynamic> json) {
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
  Null reasonDeclined;
  Null paymentMethod;
  Null courierService;
  Null trackingNumber;
  Null newimagepath;
  int? shippingFrom;
  Null shippingTo;
  Null weight;
  Null height;
  Null width;
  int? expiry;
  String? expiryAt;
  Null expectedDeliverydate;
  Wishes? userWishlist;

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
      this.userWishlist});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userWishlistId = json['user_wishlist_id'];
    offeredBy = json['offered_by'];
    offeredTo = json['offered_to'];
    tripId = json['trip_id'];
    currencyCode = json['currency_code'];
    purchaseFrom = json['purchase_from'];

    if (json['vat_price'] is int) {
      vatPrice = json['vat_price'].toDouble();
    } else {
      vatPrice = json['vat_price'];
    }
    if (json['product_price'] is int) {
      productPrice = json['product_price'].toDouble();
    } else {
      productPrice = json['product_price'];
    }
    if (json['shipping_fee'] is int) {
      shippingFee = json['shipping_fee'].toDouble();
    } else {
      shippingFee = json['shipping_fee'];
    }
    if (json['iwish_fee'] is int) {
      iwishFee = json['iwish_fee'].toDouble();
    } else {
      iwishFee = json['iwish_fee'];
    }
    if (json['traveler_fee'] is int) {
      travelerFee = json['traveler_fee'].toDouble();
    } else {
      travelerFee = json['traveler_fee'];
    }
    if (json['total_unit_price'] is int) {
      totalUnitPrice = json['total_unit_price'].toDouble();
    } else {
      totalUnitPrice = json['total_unit_price'];
    }
    if (json['total_price'] is int) {
      totalPrice = json['total_price'].toDouble();
    } else {
      totalPrice = json['total_price'];
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
        ? Wishes.fromJson(json['user_wishlist'])
        : null;
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
