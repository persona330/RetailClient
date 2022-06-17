import 'Measurement.dart';

class Price
{
  final int? idPrice;
  final int? quantity;
  final Measurement? measurement;

  Price({
    required this.idPrice,
    required this.quantity,
    required this.measurement,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      quantity: json["quantity"],
      measurement: json["measurementDTO"] != null ? Measurement.fromJson(json["measurementDTO"]) : null,
      idPrice: json["id_Price"],
    );
  }

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "measurementDTO": measurement == null ? null : measurement!.toJson(),
    "id_Price": idPrice,
  };

  int? get getIdPrice => idPrice;
  int? get getQuantity => quantity;
  Measurement? get getMeasurement => measurement;

  @override
  String toString() {
    return 'Цена №$idPrice: количество: $quantity, единица измерения $measurement}';
  }
}

abstract class PriceResult {}

// указывает на успешный запрос
class PriceGetListResultSuccess extends PriceResult
{
  List<Price> priceList = [];
  PriceGetListResultSuccess(this.priceList);
}

class PriceGetItemResultSuccess extends PriceResult
{
  Price price;
  PriceGetItemResultSuccess(this.price);
}

class PriceAddResultSuccess extends PriceResult {}

class PricePutResultSuccess extends PriceResult
{
  Price price;
  PricePutResultSuccess(this.price);
}

class PriceDeleteResultSuccess extends PriceResult {}

class PriceResultFailure extends PriceResult
{
  final String error;
  PriceResultFailure(this.error);
}

// загрузка данных
class PriceResultLoading extends PriceResult { PriceResultLoading(); }