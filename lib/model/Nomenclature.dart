import 'package:intl/intl.dart';
import 'package:retail/model/Box.dart';
import 'package:retail/model/Group.dart';
import 'package:retail/model/Measurement.dart';
import 'package:retail/model/StorageConditions.dart';
import 'Organization.dart';
import 'Product.dart';

class Nomenclature
{
  final int? idNomenclature;
  final String? name;
  final String? brand;
  final double? cost;
  final DateTime? productionDate;
  final DateTime? expirationDate;
  final double? weight;
  final double? size;
  final Group? group;
  final Organization? organization;
  final Measurement? measurement;
  final Box? box;
  final StorageConditions? storageConditions;
  final Product? product;

  Nomenclature({
    required this.idNomenclature,
    required this.name,
    required this.brand,
    required this.cost,
    required this.productionDate,
    required this.expirationDate,
    required this.weight,
    required this.size,
    required this.group,
    required this.organization,
    required this.measurement,
    required this.box,
    required this.storageConditions,
    required this.product,
  });

  factory Nomenclature.fromJson(Map<String, dynamic> json) {
    return Nomenclature(
      name: json["name"],
      brand: json["brand"],
      cost: json["cost"],
      productionDate: json["productionDate"] != null ? DateTime.tryParse(json["productionDate"]) : null,
      expirationDate: json["expirationDate"] != null ? DateTime.tryParse(json["expirationDate"]) : null,
      weight: json["weight"],
      size: json["size"],
      group: json["groupDTO"] != null ? Group.fromJson(json["groupDTO"]) : null,
      organization: json["organizationDTO"] != null ? Organization.fromJson(json["organizationDTO"]) : null,
      measurement: json["measurementDTO"] != null ? Measurement.fromJson(json["measurementDTO"]) : null,
      box: json["boxDTO"] != null ? Box.fromJson(json["boxDTO"]) : null,
      storageConditions: json["storageConditionsDTO"] != null ? StorageConditions.fromJson(json["storageConditionsDTO"]) : null,
      product: json["productDTO"] != null ? Product.fromJson(json["productDTO"]) : null,
      idNomenclature: json["id_Nomenclature"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "brand": brand,
    "cost": cost,
    "productionDate": productionDate == null ? null : DateFormat('yyyy-MM-dd').format(productionDate!),
    "expirationDate": expirationDate == null ? null : DateFormat('yyyy-MM-dd').format(expirationDate!),
    "weight": weight,
    "size": size,
    "groupDTO": group == null ? null : group!.toJson(),
    "organizationDTO": organization == null ? null : organization!.toJson(),
    "measurementDTO": measurement == null ? null : measurement!.toJson(),
    "boxDTO": box == null ? null : box!.toJson(),
    "storageConditionsDTO": storageConditions == null ? null : storageConditions!.toJson(),
    "productDTO": product == null ? null : product!.toJson(),
    "id_Nomenclature": idNomenclature,
  };

  int? get getIdNomenclature => idNomenclature;
  String? get getName => name;
  String? get getBrand => brand;
  double? get getCost => cost;
  DateTime? get getProductionDate => productionDate;
  DateTime? get getExpirationDate => expirationDate;
  double? get getWeight => weight;
  double? get getSize => size;
  Group? get getGroup => group;
  Organization? get getOrganization => organization;
  Measurement? get getMeasurement => measurement;
  Box? get getBox => box;
  StorageConditions? get getStorageConditions => storageConditions;
  Product? get getProduct => product;

  @override
  String toString() {return '$name: ?????????? $brand, ???????? $cost, ???????? ???????????????????????? $productionDate, ???????? ???????????????? $expirationDate, ?????? $weight, ?????????? $size, ???????????? $group, ?????????????? ?????????????????? $measurement';}
}

abstract class NomenclatureResult {}

// ?????????????????? ???? ???????????????? ????????????
class NomenclatureGetListResultSuccess extends NomenclatureResult
{
  List<Nomenclature> nomenclatureList = [];
  NomenclatureGetListResultSuccess(this.nomenclatureList);
}

class NomenclatureGetItemResultSuccess extends NomenclatureResult
{
  Nomenclature nomenclature;
  NomenclatureGetItemResultSuccess(this.nomenclature);
}

class NomenclatureAddResultSuccess extends NomenclatureResult {}

class NomenclaturePutResultSuccess extends NomenclatureResult
{
  Nomenclature nomenclature;
  NomenclaturePutResultSuccess(this.nomenclature);
}

class NomenclatureDeleteResultSuccess extends NomenclatureResult {}

class NomenclatureResultFailure extends NomenclatureResult
{
  final String error;
  NomenclatureResultFailure(this.error);
}

// ???????????????? ????????????
class NomenclatureResultLoading extends NomenclatureResult { NomenclatureResultLoading(); }