// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressListViewModel {
  int id;
  int user_id;
  String address_name;
  String street_address;
  int city_id;
  String city;
  String state;
  String zip_code;
  String set_as;
  AddressListViewModel({
    required this.id,
    required this.user_id,
    required this.address_name,
    required this.street_address,
    required this.city_id,
    required this.state,
    required this.zip_code,
    required this.set_as,
    required this.city,
  });
}
