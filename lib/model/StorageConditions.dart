import 'package:decimal/decimal.dart';
import 'package:retail/model/Measurement.dart';

class StorageConditions
{
  final int? idStorageConditions;
  final String? name;
  final Decimal? temperature;
  final Decimal? humidity;
  final Decimal? illumination;
  final Measurement? measuremenTemperature;
  final Measurement? measuremenHumidity;
  final Measurement? measuremenIllumination;

  StorageConditions({
    required this.idStorageConditions,
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.illumination,
    required this.measuremenTemperature,
    required this.measuremenHumidity,
    required this.measuremenIllumination,
  });

  factory StorageConditions.fromJson(Map<String, dynamic> json) {
    return StorageConditions(
      name: json["name"],
      temperature: json["temperature"],
      humidity: json["humidity"],
      illumination: json["illumination"],
      measuremenTemperature: json["measuremenTemperature"],
      measuremenHumidity: json["measuremenHumidity"],
      measuremenIllumination: json["measuremenIllumination"],
      idStorageConditions: json["id_StorageConditions"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "temperature": temperature,
    "humidity": humidity,
    "illumination": illumination,
    "measuremenTemperature": measuremenTemperature,
    "measuremenHumidity": measuremenHumidity,
    "measuremenIllumination": measuremenIllumination,
    "id_StorageConditions": idStorageConditions,
  };

  int? get getIdStorageConditions => idStorageConditions;
  String? get getName => name;
  Decimal? get getTemperature=> temperature;
  Decimal? get getHumidity => humidity;
  Decimal? get getIllumination=> illumination;
  Measurement? get getMeasuremenTemperature => measuremenTemperature;
  Measurement? get getMeasuremenHumidity => measuremenHumidity;
  Measurement? get getMeasuremenIllumination => measuremenIllumination;
}

abstract class StorageConditionsResult {}

// указывает на успешный запрос
class StorageConditionsGetListResultSuccess extends StorageConditionsResult
{
  List<StorageConditions> storageConditionsList = [];
  StorageConditionsGetListResultSuccess(this.storageConditionsList);
}

class StorageConditionsGetItemResultSuccess extends StorageConditionsResult
{
  StorageConditions storageConditions;
  StorageConditionsGetItemResultSuccess(this.storageConditions);
}

class StorageConditionsAddResultSuccess extends StorageConditionsResult {}

class StorageConditionsPutResultSuccess extends StorageConditionsResult
{
  StorageConditions storageConditions;
  StorageConditionsPutResultSuccess(this.storageConditions);
}

class StorageConditionsDeleteResultSuccess extends StorageConditionsResult {}

class StorageConditionsResultFailure extends StorageConditionsResult
{
  final String error;
  StorageConditionsResultFailure(this.error);
}

// загрузка данных
class StorageConditionsResultLoading extends StorageConditionsResult { StorageConditionsResultLoading(); }