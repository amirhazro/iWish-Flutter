class MakeOfferRequestModel {
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
  int? tripId;

  MakeOfferRequestModel(
      {this.id,
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
      this.tripId});

  MakeOfferRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userWishlistId = json['user_wishlist_id'];
    offeredTo = json['offered_to'];
    expiry = json['expiry'];
    purchaseFrom = json['purchase_from'];
    currencyCode = json['currency_code'];
    productPrice = json['product_price'];
    quantity = json['quantity'];
    totalUnitPrice = json['total_unit_price'];
    travelerFee = json['traveler_fee'];
    vatPrice = json['vat_price'];
    iwishFee = json['iwish_fee'];
    shippingFee = json['shipping_fee'];
    totalPrice = json['total_price'];
    deliveryType = json['delivery_type'];
    shippingFrom = json['shipping_from'];
    shippingTo = json['shipping_to'];
    weight = json['weight'];
    height = json['height'];
    width = json['width'];
    tripId = json['trip_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['trip_id'] = tripId;
    return data;
  }
}
