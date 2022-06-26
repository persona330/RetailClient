import 'package:retail/model/Address.dart';
import 'package:retail/model/Organization.dart';

class Store
{
  final int? idStore;
  final String? name;
  final double? totalCapacity;
  final Organization? organization;
  final Address? address;

  Store({
    required this.idStore,
    required this.name,
    required this.totalCapacity,
    required this.organization,
    required this.address,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      name: json["name"],
      totalCapacity: json["totalCapacity"],
      organization: json["organizationDTO"] != null ? Organization.fromJson(json["organizationDTO"]) : null,
      address: json["addressDTO"] != null ? Address.fromJson(json["addressDTO"]) : null,
      idStore: json["id_Store"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "totalCapacity": totalCapacity,
    "organizationDTO": organization == null ? null : organization!.toJson(),
    "addressDTO": address == null ? null : address!.toJson(),
    "id_Store": idStore,
  };

  int? get getIdStore => idStore;
  String? get getName => name;
  double? get getTotalCapacity => totalCapacity;
  Organization? get getOrganization => organization;
  Address? get getAddress => address;

  @override
  String toString() {return '$name: полная вместимость $totalCapacity, организация $organization, адрес $address';}
}

abstract class StoreResult {}

// указывает на успешный запрос
class StoreGetListResultSuccess extends StoreResult
{
  List<Store> storeList = [];
  StoreGetListResultSuccess(this.storeList);
}

class StoreGetItemResultSuccess extends StoreResult
{
  Store store;
  StoreGetItemResultSuccess(this.store);
}

class StoreAddResultSuccess extends StoreResult {}

class StorePutResultSuccess extends StoreResult
{
  Store store;
  StorePutResultSuccess(this.store);
}

class StoreDeleteResultSuccess extends StoreResult {}

class StoreResultFailure extends StoreResult
{
  final String error;
  StoreResultFailure(this.error);
}

// загрузка данных
class StoreResultLoading extends StoreResult { StoreResultLoading(); }