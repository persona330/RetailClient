import 'StorageConditions.dart';
import 'Store.dart';

class Area
{
  final int? idArea;
  final String? name;
  final double? capacity;
  final StorageConditions? storageConditions;
  final Store? store;

  Area({
    required this.idArea,
    required this.name,
    required this.capacity,
    required this.storageConditions,
    required this.store,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      name: json["name"],
      capacity: json["capacity"],
      storageConditions: json["storageConditionsDTO"] != null ? StorageConditions.fromJson(json["storageConditionsDTO"]) : null,
      store: json["storeDTO"] != null ? Store.fromJson(json["storeDTO"]) : null,
      idArea: json["id_Area"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "capacity": capacity,
    "storageConditionsDTO": storageConditions == null ? null : storageConditions!.toJson(),
    "storeDTO": store == null ? null : store!.toJson(),
    "id_Area": idArea,
  };

  int? get getIdArea => idArea;
  String? get getName => name;
  double? get getCapacity => capacity;
  StorageConditions? get getStorageConditions => storageConditions;
  Store? get getStore => store;

  @override
  String toString() {return 'idArea $idArea: название $name, вместимость $capacity, условия хранения $storageConditions, склад $store';}
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