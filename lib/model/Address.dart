class Address
{
  final int? idAddress;
  final String? apartment;
  final int? entrance;
  final String? house;
  final String? street;
  final String? region;
  final String? city;
  final String? nation;

  Address({
    required this.idAddress,
    required this.apartment,
    required this.entrance,
    required this.house,
    required this.street,
    required this.region,
    required this.city,
    required this.nation,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      apartment: json["apartment"],
      entrance: json["entrance"],
      house: json["house"],
      street: json["street"],
      region: json["region"],
      city: json["city"],
      nation: json["nation"],
      idAddress: json["id"],
  );
  }

  Map<String, dynamic> toJson() => {
    "apartment": apartment,
    "entrance": entrance,
    "house": house,
    "street": street,
    "region": region,
    "city": city,
    "nation": nation,
    "id": idAddress,
  };

  int? get getIdAddress => idAddress;
  String? get getApartment => apartment;
  int? get getEntrance => entrance;
  String? get getHouse => house;
  String? get getStreet => street;
  String? get getRegion => region;
  String? get getCity => city;
  String? get getNation => nation;
}

abstract class AddressResult {}

// указывает на успешный запрос
class AddressResultSuccess extends AddressResult
{
  List<Address> addressList = [];
  AddressResultSuccess(this.addressList);
}

// произошла ошибка
class AddressResultFailure extends AddressResult
{
  final String error;
  AddressResultFailure(this.error);
}

// загрузка данных
class AddressResultLoading extends AddressResult {
  AddressResultLoading();
}