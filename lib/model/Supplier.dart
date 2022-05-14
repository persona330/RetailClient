import 'package:retail/model/Organization.dart';
import 'package:retail/model/Position.dart';

class Supplier
{
  final int? idSupplier;
  final String? name;
  final Position? position;
  final Organization? organization;

  Supplier({
    required this.idSupplier,
    required this.name,
    required this.position,
    required this.organization,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      name: json["name"],
      position: json["position"],
      organization: json["organization"],
      idSupplier: json["id_Supplier"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "position": position,
    "organization": organization,
    "id_Supplier": idSupplier,
  };

  int? get getIdSupplier => idSupplier;
  String? get getName => name;
  Position? get getPosition => position;
  Organization? get getOrganization => organization;
}

abstract class SupplierResult {}

// указывает на успешный запрос
class SupplierGetListResultSuccess extends SupplierResult
{
  List<Supplier> supplierList = [];
  SupplierGetListResultSuccess(this.supplierList);
}

class SupplierGetItemResultSuccess extends SupplierResult
{
  Supplier supplier;
  SupplierGetItemResultSuccess(this.supplier);
}

class SupplierAddResultSuccess extends SupplierResult {}

class SupplierPutResultSuccess extends SupplierResult
{
  Supplier supplier;
  SupplierPutResultSuccess(this.supplier);
}

class SupplierDeleteResultSuccess extends SupplierResult {}

class SupplierResultFailure extends SupplierResult
{
  final String error;
  SupplierResultFailure(this.error);
}

// загрузка данных
class SupplierResultLoading extends SupplierResult { SupplierResultLoading(); }