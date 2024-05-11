class UserAddresses {
  int? id;
  int? userId;
  String? addressName;
  String? streetAddress;
  int? cityId;
  String? state;
  String? zipCode;
  String? setAs;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  City? city;

  UserAddresses({
    this.id,
    this.userId,
    this.addressName,
    this.streetAddress,
    this.cityId,
    this.state,
    this.zipCode,
    this.setAs,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.city,
  });

  UserAddresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressName = json['address_name'];
    streetAddress = json['street_address'];
    cityId = json['city_id'];
    state = json['state'];
    zipCode = json['zip_code'];
    setAs = json['set_as'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['address_name'] = addressName;
    data['street_address'] = streetAddress;
    data['city_id'] = cityId;
    data['state'] = state;
    data['zip_code'] = zipCode;
    data['set_as'] = setAs;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;
  int? stateId;
  String? stateCode;
  int? countryId;
  String? countryCode;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  bool? flag;
  String? wikiDataId;

  City(
      {this.id,
      this.name,
      this.stateId,
      this.stateCode,
      this.countryId,
      this.countryCode,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.flag,
      this.wikiDataId});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
    stateCode = json['state_code'];
    countryId = json['country_id'];
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    flag = json['flag'];
    wikiDataId = json['wiki_data_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['state_id'] = stateId;
    data['state_code'] = stateCode;
    data['country_id'] = countryId;
    data['country_code'] = countryCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['flag'] = flag;
    data['wiki_data_id'] = wikiDataId;
    return data;
  }
}
