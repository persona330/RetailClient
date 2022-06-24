import 'Address.dart';
import 'Communication.dart';
import 'Employee.dart';
import 'Organization.dart';
import 'Position.dart';

class EmployeeStore extends Employee
{
  @override
  final int? id;
  @override
  final String? surname;
  @override
  final String? name;
  @override
  final String? patronymic;
  @override
  final Address? address;
  @override
  final Communication? communication;
  @override
  final bool? free;
  @override
  final Organization? organization;
  final Position? position;

  EmployeeStore({
    required this.id,
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.address,
    required this.communication,
    required this.free,
    required this.organization,
    required this.position,
  }) : super(id: id, surname: surname, name: name, patronymic: patronymic, address: address, communication: communication, free: free, organization: organization);

  factory EmployeeStore.fromJson(Map<String, dynamic> json) {
    return EmployeeStore(
      surname: json["surname"],
      name: json["name"],
      patronymic: json["patronymic"],
      address: json["addressDTO"] != null ? Address.fromJson(json["addressDTO"]) : null,
      communication: json["communicationDTO"] != null ? Communication.fromJson(json["communicationDTO"]) : null,
      free: json["free"],
      organization: json["organizationDTO"] != null ? Organization.fromJson(json["organizationDTO"]) : null,
      position: json["positionDTO"] != null ? Position.fromJson(json["positionDTO"]) : null,
      id: json["id"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    "surname": surname,
    "name": name,
    "patronymic": patronymic,
    "addressDTO": address == null ? null : address!.toJson(),
    "communicationDTO": communication == null ? null : communication!.toJson(),
    "free": free,
    "organizationDTO": organization == null ? null : organization!.toJson(),
    "positionDTO": position == null ? null : position!.toJson(),
    "id": id,
  };

  @override
  int? get getId => id;
  @override
  String? get getSurname => name;
  @override
  String? get getName => name;
  @override
  String? get getPatronymic => patronymic;
  @override
  Address? get getAddress => address;
  @override
  Communication? get getCommunication => communication;
  @override
  bool? get getFree => free;
  @override
  Organization? get getOrganization => organization;
  Position? get getPosition => position;

  @override
  String toString() { return 'Фамилия $surname, имя $name, отчество $patronymic, организация $organization, должность $position'; }
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