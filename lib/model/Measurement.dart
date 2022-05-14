class Measurement
{
  final int? idMeasurement;
  final String? name;
  final String? fullName;

  Measurement({
    required this.idMeasurement,
    required this.name,
    required this.fullName,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      name: json["name"],
      fullName: json["fullName"],
      idMeasurement: json["id_Measurement"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "fullName": fullName,
    "id_easurement": idMeasurement,
  };

  int? get getIdMeasurement => idMeasurement;
  String? get getName => name;
  String? get getFullName => fullName;
}

abstract class MeasurementResult {}

// указывает на успешный запрос
class MeasurementGetListResultSuccess extends MeasurementResult
{
  List<Measurement> measurementList = [];
  MeasurementGetListResultSuccess(this.measurementList);
}

class MeasurementGetItemResultSuccess extends MeasurementResult
{
  Measurement measurement;
  MeasurementGetItemResultSuccess(this.measurement);
}

class MeasurementAddResultSuccess extends MeasurementResult {}

class MeasurementPutResultSuccess extends MeasurementResult
{
  Measurement measurement;
  MeasurementPutResultSuccess(this.measurement);
}

class MeasurementDeleteResultSuccess extends MeasurementResult {}

class MeasurementResultFailure extends MeasurementResult
{
  final String error;
  MeasurementResultFailure(this.error);
}

// загрузка данных
class MeasurementResultLoading extends MeasurementResult { MeasurementResultLoading(); }