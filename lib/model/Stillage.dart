import 'package:decimal/decimal.dart';
import 'package:retail/model/Area.dart';

class Stillage
{
  final int? idStillage;
  final String? number;
  final Decimal? size;
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
      area: json["area"],
      idStillage: json["id_Stillage"],
    );
  }

  Map<String, dynamic> toJson() => {
    "number": number,
    "size": size,
    "area": area,
    "id_Stillage": idStillage,
  };

  int? get getIdStillage => idStillage;
  String? get getNumber => number;
  Decimal? get getSize => size;
  Area? get getArea => area;
}

abstract class StillageResult {}

// указывает на успешный запрос
class StillageGetListResultSuccess extends StillageResult
{
  List<Stillage> addressList = [];
  StillageGetListResultSuccess(this.addressList);
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