import 'package:retail/model/Address.dart';
import 'package:retail/model/Communication.dart';

class Organization
{
  final int? idOrganization;
  final String? name;
  final String? inn;
  final String? kpp;
  final Address? address;
  final Communication? communication;

  Organization({
    required this.idOrganization,
    required this.name,
    required this.inn,
    required this.kpp,
    required this.address,
    required this.communication,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      name: json["name"],
      inn: json["inn"],
      kpp: json["kpp"],
      address: json["addressDTO"] != null ? Address.fromJson(json["addressDTO"]) : null,
      communication: json["communicationDTO"] != null ? Communication.fromJson(json['communicationDTO']) : null,
      idOrganization: json["id_Organization"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "inn": inn,
    "kpp": kpp,
    "addressDTO": address == null ? null : address!.toJson(),
    "communicationDTO": communication == null ? null : communication!.toJson(),
    "id_Organization": idOrganization,
  };

  int? get getIdOrganization => idOrganization;
  String? get getName => name;
  String? get getInn => inn;
  String? get getKpp => kpp;
  Address? get getAddress => address;
  Communication? get getCommunication => communication;

  @override
  String toString() {return 'Организация $idOrganization: название $name, адрес $address, средства связи $communication, ИНН $inn, КПП $kpp';}
}

abstract class OrganizationResult {}

// указывает на успешный запрос
class OrganizationGetListResultSuccess extends OrganizationResult
{
  List<Organization> organizationList = [];
  OrganizationGetListResultSuccess(this.organizationList);
}

class OrganizationGetItemResultSuccess extends OrganizationResult
{
  Organization organization;
  OrganizationGetItemResultSuccess(this.organization);
}

class OrganizationAddResultSuccess extends OrganizationResult {}

class OrganizationPutResultSuccess extends OrganizationResult
{
  Organization organization;
  OrganizationPutResultSuccess(this.organization);
}

class OrganizationDeleteResultSuccess extends OrganizationResult {}

class OrganizationResultFailure extends OrganizationResult
{
  final String error;
  OrganizationResultFailure(this.error);
}

// загрузка данных
class OrganizationResultLoading extends OrganizationResult { OrganizationResultLoading(); }