import 'package:iwish_flutter/models/base_response_model.dart';

class MakeAnOfferResponseModel extends BaseResponseModel {
  Data? data;

  MakeAnOfferResponseModel(
      {super.status, super.statusCode, super.message, this.data, super.error});

  MakeAnOfferResponseModel.fromJson(Map<String, dynamic> json) {
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
  Offer? offer;

  Data({this.offer});

  Data.fromJson(Map<String, dynamic> json) {
    offer = json['offer'] != null ? Offer.fromJson(json['offer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (offer != null) {
      data['offer'] = offer!.toJson();
    }
    return data;
  }
}

class Offer {
  String? offerStatus;
  dynamic reasonDeclined;
  dynamic paymentMethod;
  dynamic courierService;
  dynamic trackingNumber;
  dynamic newimagepath;
  dynamic expectedDeliverydate;
  int? id;
  int? userWishlistId;
  int? offeredTo;
  int? expiry;
  String? purchaseFrom;
  String? currencyCode;
  String? productPrice;
  String? quantity;
  double? totalUnitPrice;
  String? travelerFee;
  String? vatPrice;
  String? iwishFee;
  String? shippingFee;
  double? totalPrice;
  String? deliveryType;
  dynamic shippingFrom;
  dynamic shippingTo;
  dynamic weight;
  dynamic height;
  dynamic width;
  String? offeredBy;
  String? expiryAt;

  Offer(
      {this.offerStatus,
      this.reasonDeclined,
      this.paymentMethod,
      this.courierService,
      this.trackingNumber,
      this.newimagepath,
      this.expectedDeliverydate,
      this.id,
      this.userWishlistId,
      this.offeredTo,
      this.expiry,
      this.purchaseFrom,
      this.currencyCode,
      this.productPrice,
      this.quantity,
      this.totalUnitPrice,
      this.travelerFee,
      this.vatPrice,
      this.iwishFee,
      this.shippingFee,
      this.totalPrice,
      this.deliveryType,
      this.shippingFrom,
      this.shippingTo,
      this.weight,
      this.height,
      this.width,
      this.offeredBy,
      this.expiryAt});

  Offer.fromJson(Map<String, dynamic> json) {
    offerStatus = json['offer_status'];
    reasonDeclined = json['reason_declined'];
    paymentMethod = json['payment_method'];
    courierService = json['courier_service'];
    trackingNumber = json['tracking_number'];
    newimagepath = json['newimagepath'];
    expectedDeliverydate = json['expected_deliverydate'];
    id = json['id'];
    userWishlistId = json['user_wishlist_id'];
    offeredTo = json['offered_to'];
    expiry = json['expiry'];
    purchaseFrom = json['purchase_from'];
    currencyCode = json['currency_code'];
    productPrice = json['product_price'];
    quantity = json['quantity'];
    if (json['total_unit_price'] is double) {
      totalUnitPrice = json['total_unit_price'];
    } else {
      totalUnitPrice = json['total_unit_price'].toDouble();
    }
    travelerFee = json['traveler_fee'];
    vatPrice = json['vat_price'];
    iwishFee = json['iwish_fee'];
    shippingFee = json['shipping_fee'];

    if (json['total_price'] is double) {
      totalPrice = json['total_price'];
    } else {
      totalPrice = json['total_price'].toDouble();
    }
    deliveryType = json['delivery_type'];
    shippingFrom = json['shipping_from'];
    shippingTo = json['shipping_to'];
    weight = json['weight'];
    height = json['height'];
    width = json['width'];
    offeredBy = json['offered_by'];
    expiryAt = json['expiry_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offer_status'] = offerStatus;
    data['reason_declined'] = reasonDeclined;
    data['payment_method'] = paymentMethod;
    data['courier_service'] = courierService;
    data['tracking_number'] = trackingNumber;
    data['newimagepath'] = newimagepath;
    data['expected_deliverydate'] = expectedDeliverydate;
    data['id'] = id;
    data['user_wishlist_id'] = userWishlistId;
    data['offered_to'] = offeredTo;
    data['expiry'] = expiry;
    data['purchase_from'] = purchaseFrom;
    data['currency_code'] = currencyCode;
    data['product_price'] = productPrice;
    data['quantity'] = quantity;
    data['total_unit_price'] = totalUnitPrice;
    data['traveler_fee'] = travelerFee;
    data['vat_price'] = vatPrice;
    data['iwish_fee'] = iwishFee;
    data['shipping_fee'] = shippingFee;
    data['total_price'] = totalPrice;
    data['delivery_type'] = deliveryType;
    data['shipping_from'] = shippingFrom;
    data['shipping_to'] = shippingTo;
    data['weight'] = weight;
    data['height'] = height;
    data['width'] = width;
    data['offered_by'] = offeredBy;
    data['expiry_at'] = expiryAt;
    return data;
  }
}
