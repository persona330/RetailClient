import 'package:decimal/decimal.dart';
import 'package:retail/model/Group.dart';
import 'package:retail/model/Stillage.dart';

class Shelf
{
  final int? idShelf;
  final Decimal? size;
  final String? number;
  final Group? group;
  final Stillage? stillage;

  Shelf({
    required this.idShelf,
    required this.size,
    required this.number,
    required this.group,
    required this.stillage,
  });

  factory Shelf.fromJson(Map<String, dynamic> json) {
    return Shelf(
      size: json["size"],
      number: json["number"],
      group: json["group"],
      stillage: json["stillage"],
      idShelf: json["id_Shelf"],
    );
  }

  Map<String, dynamic> toJson() => {
    "size": size,
    "number": number,
    "group": group,
    "stillage": stillage,
    "id_Shelf": idShelf,
  };

  int? get getIdShelf => idShelf;
  Decimal? get getSize => size;
  String? get getNumber => number;
  Group? get getGroup => group;
  Stillage? get getStillage => stillage;
}

abstract class ShelfResult {}

// указывает на успешный запрос
class ShelfGetListResultSuccess extends ShelfResult
{
  List<Shelf> shelfList = [];
  ShelfGetListResultSuccess(this.shelfList);
}

class ShelfGetItemResultSuccess extends ShelfResult
{
  Shelf shelf;
  ShelfGetItemResultSuccess(this.shelf);
}

class ShelfAddResultSuccess extends ShelfResult {}

class ShelfPutResultSuccess extends ShelfResult
{
  Shelf shelf;
  ShelfPutResultSuccess(this.shelf);
}

class ShelfDeleteResultSuccess extends ShelfResult {}

class ShelfResultFailure extends ShelfResult
{
  final String error;
  ShelfResultFailure(this.error);
}

// загрузка данных
class ShelfResultLoading extends ShelfResult { ShelfResultLoading(); }