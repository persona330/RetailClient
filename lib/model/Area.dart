import 'package:decimal/decimal.dart';

class Area
{
  final int? idArea;
  final String? name;
  final Decimal? capacity;
  //final StorageConditions? storageConditions;
  //final Store? store;

  Area({
    required this.idArea,
    required this.name,
    required this.capacity,
    //required this.storageConditions,
    //required this.store,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      name: json["name"],
      capacity: json["capacity"],
      //storageConditions: json["storageConditions"],
      //store: json["store"],
      idArea: json["id_Area"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "capacity": capacity,
    //"storageConditions": storageConditions,
    //"store": store,
    "id_Area": idArea,
  };

  int? get getIdArea => idArea;
  String? get getName => name;
  Decimal? get getCapacity => capacity;
  //StorageConditions? get getStorageConditions => storageConditions;
  //Store? get getStore => store;
}

abstract class AreaResult {}

// указывает на успешный запрос
class AreaGetListResultSuccess extends AreaResult
{
  List<Area> areaList = [];
  AreaGetListResultSuccess(this.areaList);
}

class AreaGetItemResultSuccess extends AreaResult
{
  Area area;
  AreaGetItemResultSuccess(this.area);
}

class AreaAddResultSuccess extends AreaResult {}

class AreaPutResultSuccess extends AreaResult
{
  Area area;
  AreaPutResultSuccess(this.area);
}

class AreaDeleteResultSuccess extends AreaResult {}

class AreaResultFailure extends AreaResult
{
  final String error;
  AreaResultFailure(this.error);
}

// загрузка данных
class AreaResultLoading extends AreaResult { AreaResultLoading(); }