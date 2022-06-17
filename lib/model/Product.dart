import 'Price.dart';

class Product
{
  final int? idProduct;
  final int? mengeAufLager;
  final Price? price;

  Product({
    required this.idProduct,
    required this.mengeAufLager,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      mengeAufLager: json["mengeAufLager"],
      price: json["priceDTO"] != null ? Price.fromJson(json["priceDTO"]) : null,
      idProduct: json["id_Product"],
    );
  }

  Map<String, dynamic> toJson() => {
    "mengeAufLager": mengeAufLager,
    "priceDTO": price == null ? null : price!.toJson(),
    "id_Product": idProduct,
  };

  int? get getIdProduct => idProduct;
  int? get getMengeAufLager => mengeAufLager;
  Price? get getPrice => price;

  @override
  String toString() {
    return 'Товар №$idProduct: количество в начиличии $mengeAufLager, цена $price}';
  }
}

abstract class ProductResult {}

// указывает на успешный запрос
class ProductGetListResultSuccess extends ProductResult
{
  List<Product> productList = [];
  ProductGetListResultSuccess(this.productList);
}

class ProductGetItemResultSuccess extends ProductResult
{
  Product product;
  ProductGetItemResultSuccess(this.product);
}

class ProductAddResultSuccess extends ProductResult {}

class ProductPutResultSuccess extends ProductResult
{
  Product product;
  ProductPutResultSuccess(this.product);
}

class ProductDeleteResultSuccess extends ProductResult {}

class ProductResultFailure extends ProductResult
{
  final String error;
  ProductResultFailure(this.error);
}

// загрузка данных
class ProductResultLoading extends ProductResult { ProductResultLoading(); }