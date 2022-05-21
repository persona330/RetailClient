import 'package:decimal/decimal.dart';
import 'package:retail/model/Group.dart';
import 'package:retail/model/Stillage.dart';

class Shelf
{
  final int? idShelf;
  final double? size;
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
      group: json["groupDTO"] != null ? Group.fromJson(json["groupDTO"]) : null,
      stillage: json["stillageDTO"] != null ? Stillage.fromJson(json["stillageDTO"]) : null,
      idShelf: json["id_Shelf"],
    );
  }

  Map<String, dynamic> toJson() => {
    "size": size,
    "number": number,
    "groupDTO": group == null ? null : group!.toJson(),
    "stillageDTO": stillage == null ? null : stillage!.toJson(),
    "id_Shelf": idShelf,
  };

  int? get getIdShelf => idShelf;
  double? get getSize => size;
  String? get getNumber => number;
  Group? get getGroup => group;
  Stillage? get getStillage => stillage;

  @override
  String toString() {return 'Полка $idShelf: вместимость $size, номер $number, группа товаров $group, стеллаж $stillage';}
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