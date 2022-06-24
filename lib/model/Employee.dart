import 'package:retail/model/Person.dart';

import 'Address.dart';
import 'Communication.dart';
import 'Organization.dart';

class Employee extends Person
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
  final bool? free;
  final Organization? organization;

  Employee({
    required this.id,
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.address,
    required this.communication,
    required this.free,
    required this.organization,
  }) : super(id: id, surname: surname, name: name, patronymic: patronymic, address: address, communication: communication);

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      surname: json["surname"],
      name: json["name"],
      patronymic: json["patronymic"],
      address: json["addressDTO"] != null ? Address.fromJson(json["addressDTO"]) : null,
      communication: json["communicationDTO"] != null ? Communication.fromJson(json["communicationDTO"]) : null,
      free: json["free"],
      organization: json["organizationDTO"] != null ? Organization.fromJson(json["organizationDTO"]) : null,
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "surname": surname,
    "name": name,
    "patronymic": patronymic,
    "addressDTO": address == null ? null : address!.toJson(),
    "communicationDTO": communication == null ? null : communication!.toJson(),
    "free": free,
    "organizationDTO": organization == null ? null : organization!.toJson(),
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
  bool? get getFree => free;
  Organization? get getOrganization => organization;

  @override
  String toString() { return 'Фамилия $surname, имя $name, отчество $patronymic, организация $organization'; }
}

abstract class EmployeeResult {}

// указывает на успешный запрос
class EmployeeGetListResultSuccess extends EmployeeResult
{
  List<Employee> employeeList = [];
  EmployeeGetListResultSuccess(this.employeeList);
}

class EmployeeGetItemResultSuccess extends EmployeeResult
{
  Employee employee;
  EmployeeGetItemResultSuccess(this.employee);
}

class EmployeeAddResultSuccess extends EmployeeResult {}

class EmployeePutResultSuccess extends EmployeeResult
{
  Employee employee;
  EmployeePutResultSuccess(this.employee);
}

class EmployeeDeleteResultSuccess extends EmployeeResult {}

class EmployeeResultFailure extends EmployeeResult
{
  final String error;
  EmployeeResultFailure(this.error);
}

// загрузка данных
class EmployeeResultLoading extends EmployeeResult { EmployeeResultLoading(); }