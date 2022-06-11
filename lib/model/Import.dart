import 'package:retail/model/ConsignmentNote.dart';
import 'Nomenclature.dart';

class Import
{
  final int? idImport;
  final int? quantity;
  final double? cost;
  final int? vat;
  final ConsignmentNote? consignmentNote;
  final Nomenclature? nomenclature;

  Import({
    required this.idImport,
    required this.quantity,
    required this.cost,
    required this.vat,
    required this.consignmentNote,
    required this.nomenclature,
  });

  factory Import.fromJson(Map<String, dynamic> json) {
    return Import(
      quantity: json["quantity"],
      cost: json["cost"],
      vat: json["vat"],
      consignmentNote: json["consignmentNoteDTO"] != null ? ConsignmentNote.fromJson(json["consignmentNoteDTO"]) : null,
      nomenclature: json["nomenclatureDTO"] != null ? Nomenclature.fromJson(json["nomenclatureDTO"]) : null,
      idImport: json["id_Import"],
    );
  }

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "cost": cost,
    "vat": vat,
    "consignmentNoteDTO": consignmentNote == null ? null : consignmentNote!.toJson(),
    "nomenclatureDTO": nomenclature == null ? null : nomenclature!.toJson(),
    "id_Import": idImport,
  };

  int? get getIdImport => idImport;
  int? get getQuantity => quantity;
  double? get getCost => cost;
  int? get getVat => vat;
  ConsignmentNote? get getConsignmentNote => consignmentNote;
  Nomenclature? get getNomenclature => nomenclature;

  @override
  String toString() {return 'Привоз $idImport: колличество $quantity, цены $cost, НДС $vat, накладная $consignmentNote, номенклатура $nomenclature';}
}

abstract class ImportResult {}

// указывает на успешный запрос
class ImportGetListResultSuccess extends ImportResult
{
  List<Import> importList = [];
  ImportGetListResultSuccess(this.importList);
}

class ImportGetItemResultSuccess extends ImportResult
{
  Import import;
  ImportGetItemResultSuccess(this.import);
}

class ImportAddResultSuccess extends ImportResult {}

class ImportPutResultSuccess extends ImportResult
{
  Import import;
  ImportPutResultSuccess(this.import);
}

class ImportDeleteResultSuccess extends ImportResult {}

class ImportResultFailure extends ImportResult
{
  final String error;
  ImportResultFailure(this.error);
}

// загрузка данных
class ImportResultLoading extends ImportResult { ImportResultLoading(); }