import 'package:decimal/decimal.dart';
import 'package:retail/model/Area.dart';

class Stillage
{
  final int? idStillage;
  final String? number;
  final double? size;
  final Area? area;

  Stillage({
    required this.idStillage,
    required this.number,
    required this.size,
    required this.area,
  });

  factory Stillage.fromJson(Map<String, dynamic> json) {
    return Stillage(
      number: json["number"],
      size: json["size"],
      area: json["areaDTO"] != null ? Area.fromJson(json["areaDTO"]) : null,
      idStillage: json["id_Stillage"],
    );
  }

  Map<String, dynamic> toJson() => {
    "number": number,
    "size": size,
    "areaDTO": area == null ? null : area!.toJson(),
    "id_Stillage": idStillage,
  };

  int? get getIdStillage => idStillage;
  String? get getNumber => number;
  double? get getSize => size;
  Area? get getArea => area;

  @override
  String toString() {return 'Стеллаж $idStillage: номер $number, вместимость $size, зона $area}';}
}

abstract class StillageResult {}

// указывает на успешный запрос
class StillageGetListResultSuccess extends StillageResult
{
  List<Stillage> stillageList = [];
  StillageGetListResultSuccess(this.stillageList);
}

class StillageGetItemResultSuccess extends StillageResult
{
  Stillage stillage;
  StillageGetItemResultSuccess(this.stillage);
}

class StillageAddResultSuccess extends StillageResult {}

class StillagePutResultSuccess extends StillageResult
{
  Stillage stillage;
  StillagePutResultSuccess(this.stillage);
}

class StillageDeleteResultSuccess extends StillageResult {}

class StillageResultFailure extends StillageResult
{
  final String error;
  StillageResultFailure(this.error);
}

// загрузка данных
class StillageResultLoading extends StillageResult { StillageResultLoading(); }