import 'package:decimal/decimal.dart';
import 'package:retail/model/Box.dart';
import 'package:retail/model/Group.dart';
import 'package:retail/model/Measurement.dart';
import 'package:retail/model/Producer.dart';
import 'package:retail/model/StorageConditions.dart';

class Nomenclature
{
  final int? idNomenclature;
  final String? name;
  final String? brand;
  final Decimal? cost;
  final DateTime? productionDate;
  final DateTime? expirationDate;
  final Decimal? weight;
  final Decimal? size;
  final Group? group;
  final Producer? producer;
  final Measurement? measurement;
  final Box? box;
  final StorageConditions? storageConditions;
  //final Box? box;

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
    required this.producer,
    required this.measurement,
    required this.box,
    required this.storageConditions,
  });

  factory Nomenclature.fromJson(Map<String, dynamic> json) {
    return Nomenclature(
      name: json["name"],
      brand: json["brand"],
      cost: json["cost"],
      productionDate: json["productionDate"],
      expirationDate: json["expirationDate"],
      weight: json["weight"],
      size: json["size"],
      group: json["group"],
      producer: json["producer"],
      measurement: json["measurement"],
      box: json["box"],
      storageConditions: json["storageConditions"],
      idNomenclature: json["id_Nomenclature"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "brand": brand,
    "cost": cost,
    "productionDate": productionDate,
    "expirationDate": expirationDate,
    "weight": weight,
    "size": size,
    "group": group,
    "producer": producer,
    "measurement": measurement,
    "box": box,
    "storageConditions": storageConditions,
    "id_Nomenclature": idNomenclature,
  };

  int? get getIdNomenclature => idNomenclature;
  String? get getName => name;
  String? get getBrand => brand;
  Decimal? get getCost => cost;
  DateTime? get getProductionDate => productionDate;
  DateTime? get getExpirationDate => expirationDate;
  Decimal? get getWeight => weight;
  Decimal? get getSize => size;
  Group? get getGroup => group;
  Producer? get getProducer => producer;
  Measurement? get getMeasurement => measurement;
  Box? get getBox => box;
  StorageConditions? get getStorageConditions => storageConditions;
}

abstract class NomenclatureResult {}

// указывает на успешный запрос
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

// загрузка данных
class NomenclatureResultLoading extends NomenclatureResult { NomenclatureResultLoading(); }