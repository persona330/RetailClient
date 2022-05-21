import 'package:retail/model/EmployeeStore.dart';
import 'package:retail/model/Supplier.dart';

class ConsignmentNote
{
  final int? idConsignmentNote;
  final String? number;
  final DateTime? arrivalDate;
  final Supplier? supplier;
  final EmployeeStore? employeeStore;
  final bool? forReturn;

  ConsignmentNote({
    required this.idConsignmentNote,
    required this.number,
    required this.arrivalDate,
    required this.supplier,
    required this.employeeStore,
    required this.forReturn,
  });

  factory ConsignmentNote.fromJson(Map<String, dynamic> json) {
    return ConsignmentNote(
      number: json["number"],
      arrivalDate: json["arrivalDate"],
      supplier: json["supplierDTO"] != null ? Supplier.fromJson(json["supplierDTO"]) : null,
      employeeStore: json["employeeStoreDTO"] != null ? EmployeeStore.fromJson(json["employeeStoreDTO"]) : null,
      forReturn: json["forReturn"],
      idConsignmentNote: json["id_ConsignmentNote"],
    );
  }

  Map<String, dynamic> toJson() => {
    "number": number,
    "arrivalDate": arrivalDate,
    "supplierDTO": supplier == null ? null : supplier!.toJson(),
    "employeeStoreDTO": employeeStore == null ? null : employeeStore!.toJson(),
    "forReturn": forReturn,
    "id_ConsignmentNote": idConsignmentNote,
  };

  int? get getIdConsignmentNote => idConsignmentNote;
  String? get getNumber => number;
  DateTime? get getArrivalDate => arrivalDate;
  Supplier? get getSupplier => supplier;
  EmployeeStore? get getEmployeeStore => employeeStore;
  bool? get getForReturn => forReturn;

  @override
  String toString() {
    return 'Накладная $idConsignmentNote: номер $number, дата прибытия $arrivalDate, поставщик $supplier, работник склада $employeeStore, на возврат $forReturn}';
  }
}

abstract class ConsignmentNoteResult {}

// указывает на успешный запрос
class ConsignmentNoteGetListResultSuccess extends ConsignmentNoteResult
{
  List<ConsignmentNote> consignmentNoteList = [];
  ConsignmentNoteGetListResultSuccess(this.consignmentNoteList);
}

class ConsignmentNoteGetItemResultSuccess extends ConsignmentNoteResult
{
  ConsignmentNote consignmentNote;
  ConsignmentNoteGetItemResultSuccess(this.consignmentNote);
}

class ConsignmentNoteAddResultSuccess extends ConsignmentNoteResult {}

class ConsignmentNotePutResultSuccess extends ConsignmentNoteResult
{
  ConsignmentNote consignmentNote;
  ConsignmentNotePutResultSuccess(this.consignmentNote);
}

class ConsignmentNoteDeleteResultSuccess extends ConsignmentNoteResult {}

class ConsignmentNoteResultFailure extends ConsignmentNoteResult
{
  final String error;
  ConsignmentNoteResultFailure(this.error);
}

// загрузка данных
class ConsignmentNoteResultLoading extends ConsignmentNoteResult { ConsignmentNoteResultLoading(); }