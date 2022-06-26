import 'package:retail/model/Measurement.dart';

class StorageConditions
{
  final int? idStorageConditions;
  final String? name;
  final double? temperature;
  final double? humidity;
  final double? illumination;
  final Measurement? measurementTemperature;
  final Measurement? measurementHumidity;
  final Measurement? measurementIllumination;

  StorageConditions({
    required this.idStorageConditions,
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.illumination,
    required this.measurementTemperature,
    required this.measurementHumidity,
    required this.measurementIllumination,
  });

  factory StorageConditions.fromJson(Map<String, dynamic> json) {
    return StorageConditions(
      name: json["name"],
      temperature: json["temperature"],
      humidity: json["humidity"],
      illumination: json["illumination"],
      measurementTemperature: json["measurementTemperatureDTO"] != null ? Measurement.fromJson(json["measurementTemperatureDTO"]) : null,
      measurementHumidity: json["measurementHumidityDTO"] != null ? Measurement.fromJson(json["measurementHumidityDTO"]) : null,
      measurementIllumination: json["measurementIlluminationDTO"] != null ? Measurement.fromJson(json["measurementIlluminationDTO"]) : null,
      idStorageConditions: json["id_StorageConditions"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "temperature": temperature,
    "humidity": humidity,
    "illumination": illumination,
    "measurementTemperatureDTO": measurementTemperature == null ? null : measurementTemperature!.toJson(),
    "measurementHumidityDTO": measurementHumidity == null ? null : measurementHumidity!.toJson(),
    "measurementIlluminationDTO": measurementIllumination == null ? null : measurementIllumination!.toJson(),
    "id_StorageConditions": idStorageConditions,
  };

  int? get getIdStorageConditions => idStorageConditions;
  String? get getName => name;
  double? get getTemperature=> temperature;
  double? get getHumidity => humidity;
  double? get getIllumination=> illumination;
  Measurement? get getMeasurementTemperature => measurementTemperature;
  Measurement? get getMeasurementHumidity => measurementHumidity;
  Measurement? get getMeasurementIllumination => measurementIllumination;

  @override
  String toString() {return '$name: температура $temperature $measurementTemperature, влажность $humidity $measurementHumidity, освещенность $illumination $measurementIllumination';}
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