import 'Organization.dart';
import 'Position.dart';

class EmployeeStore
{
  final int? idEmployeeStore;
  final Position? position;
  final Organization? organization;

  EmployeeStore({
    required this.idEmployeeStore,
    required this.position,
    required this.organization,
  });

  factory EmployeeStore.fromJson(Map<String, dynamic> json) {
    return EmployeeStore(
      position: json["positionDTO"] != null ? Position.fromJson(json["positionDTO"]) : null,
      organization: json["organizationDTO"] != null ? Organization.fromJson(json["organizationDTO"]) : null,
      idEmployeeStore: json["id_EmployeeStore"],
    );
  }

  Map<String, dynamic> toJson() => {
    "positionDTO": position == null ? null : position!.toJson(),
    "organizationDTO": organization == null ? null : organization!.toJson(),
    "id_EmployeeStore": idEmployeeStore,
  };

  int? get getIdEmployeeStore=> idEmployeeStore;
  Position? get getPosition => position;
  Organization? get getOrganization => organization;

  @override
  String toString() {
    return 'Сотрудник склада $idEmployeeStore: должность $position, организация $organization}';
  }
}

abstract class EmployeeStoreResult {}

// указывает на успешный запрос
class EmployeeStoreGetListResultSuccess extends EmployeeStoreResult
{
  List<EmployeeStore> employeeStoreList = [];
  EmployeeStoreGetListResultSuccess(this.employeeStoreList);
}

class EmployeeStoreGetItemResultSuccess extends EmployeeStoreResult
{
  EmployeeStore employeeStore;
  EmployeeStoreGetItemResultSuccess(this.employeeStore);
}

class EmployeeStoreAddResultSuccess extends EmployeeStoreResult {}

class EmployeeStorePutResultSuccess extends EmployeeStoreResult
{
  EmployeeStore employeeStore;
  EmployeeStorePutResultSuccess(this.employeeStore);
}

class EmployeeStoreDeleteResultSuccess extends EmployeeStoreResult {}

class EmployeeStoreResultFailure extends EmployeeStoreResult
{
  final String error;
  EmployeeStoreResultFailure(this.error);
}

// загрузка данных
class EmployeeStoreResultLoading extends EmployeeStoreResult { EmployeeStoreResultLoading(); }