class Trips {
  int? id;
  String? tripType;
  int? userId;
  dynamic residentCityid;
  dynamic residentCountryid;
  int? fromCityid;
  int? fromCountryid;
  int? toCityid;
  int? toCountryid;
  int? isResident;
  String? departureDate;
  String? returnDate;
  String? tripStatus;
  String? createdAt;
  String? updatedAt;
  FromCity? fromCity;
  FromCity? toCity;
  int? takenOrders;

  Trips(
      {this.id,
      this.tripType,
      this.userId,
      this.residentCityid,
      this.residentCountryid,
      this.fromCityid,
      this.fromCountryid,
      this.toCityid,
      this.toCountryid,
      this.isResident,
      this.departureDate,
      this.returnDate,
      this.tripStatus,
      this.createdAt,
      this.updatedAt,
      this.fromCity,
      this.toCity,
      this.takenOrders});

  Trips.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tripType = json['trip_type'];
    userId = json['user_id'];
    residentCityid = json['resident_cityid'];
    residentCountryid = json['resident_countryid'];
    fromCityid = json['from_cityid'];
    fromCountryid = json['from_countryid'];
    toCityid = json['to_cityid'];
    toCountryid = json['to_countryid'];
    isResident = json['is_resident'];
    departureDate = json['departure_date'];
    returnDate = json['return_date'];
    tripStatus = json['trip_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fromCity =
        json['from_city'] != null ? FromCity.fromJson(json['from_city']) : null;
    toCity =
        json['to_city'] != null ? FromCity.fromJson(json['to_city']) : null;
    takenOrders = json['takenOrders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trip_type'] = tripType;
    data['user_id'] = userId;
    data['resident_cityid'] = residentCityid;
    data['resident_countryid'] = residentCountryid;
    data['from_cityid'] = fromCityid;
    data['from_countryid'] = fromCountryid;
    data['to_cityid'] = toCityid;
    data['to_countryid'] = toCountryid;
    data['is_resident'] = isResident;
    data['departure_date'] = departureDate;
    data['return_date'] = returnDate;
    data['trip_status'] = tripStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (fromCity != null) {
      data['from_city'] = fromCity!.toJson();
    }
    if (toCity != null) {
      data['to_city'] = toCity!.toJson();
    }
    data['takenOrders'] = takenOrders;
    return data;
  }
}

class FromCity {
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
  CountriesMaster? countriesMaster;

  FromCity({
    this.id,
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
    this.wikiDataId,
    this.countriesMaster,
  });

  FromCity.fromJson(Map<String, dynamic> json) {
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
    countriesMaster = json['countries_master'] != null
        ? CountriesMaster.fromJson(json['countries_master'])
        : null;
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
    if (countriesMaster != null) {
      data['countries_master'] = countriesMaster!.toJson();
    }
    return data;
  }
}

class CountriesMaster {
  int? id;
  String? emoji;

  CountriesMaster({this.id, this.emoji});

  CountriesMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emoji = json['emoji'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['emoji'] = emoji;
    return data;
  }
}
