import 'Address.dart';
import 'Communication.dart';

class Person
{
  final int? id;
  final String? surname;
  final String? name;
  final String? patronymic;
  final Address? address;
  final Communication? communication;

  Person({
    required this.id,
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.address,
    required this.communication,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      surname: json["surname"],
      name: json["name"],
      patronymic: json["patronymic"],
      address: json["addressDTO"] != null ? Address.fromJson(json["storageConditionsDTO"]) : null,
      communication: json["communicationDTO"] != null ? Communication.fromJson(json["communicationDTO"]) : null,
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "surname": surname,
    "name": name,
    "patronymic": patronymic,
    "addressDTO": address == null ? null : address!.toJson(),
    "communicationDTO": communication == null ? null : communication!.toJson(),
    "id": id,
  };

  int? get getId => id;
  String? get getSurname => name;
  String? get getName => name;
  String? get getPatronymic => patronymic;
  Address? get getAddress => address;
  Communication? get getCommunication => communication;

  @override
  String toString() { return 'Пользователь №$id: фамилия $surname, имя $name, отчество $patronymic'; }
}

abstract class PersonResult {}

// указывает на успешный запрос
class PersonGetListResultSuccess extends PersonResult
{
  List<Person> personList = [];
  PersonGetListResultSuccess(this.personList);
}

class PersonGetItemResultSuccess extends PersonResult
{
  Person person;
  PersonGetItemResultSuccess(this.person);
}

class PersonAddResultSuccess extends PersonResult {}

class PersonPutResultSuccess extends PersonResult
{
  Person person;
  PersonPutResultSuccess(this.person);
}

class PersonDeleteResultSuccess extends PersonResult {}

class PersonResultFailure extends PersonResult
{
  final String error;
  PersonResultFailure(this.error);
}

// загрузка данных
class PersonResultLoading extends PersonResult { PersonResultLoading(); }