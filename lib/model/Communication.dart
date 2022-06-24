class Communication
{
  final int? idCommunication;
  final String? phone;
  final String? email;

  Communication({
    required this.idCommunication,
    required this.phone,
    required this.email,
  });

  factory Communication.fromJson(Map<String, dynamic> json) {
    return Communication(
      phone: json["phone"],
      email: json["email"],
      idCommunication: json["id_Communication"],
    );
  }

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "email": email,
    "id_Communication": idCommunication,
  };

  int? get getIdCommunication => idCommunication;
  String? get getPhone => phone;
  String? get getEmail => email;

  @override
  String toString() {
    return 'Телефон $phone, эл.адрес $email';
  }
}

abstract class CommunicationResult {}

// указывает на успешный запрос
class CommunicationGetListResultSuccess extends CommunicationResult
{
  List<Communication> communicationList = [];
  CommunicationGetListResultSuccess(this.communicationList);
}

class CommunicationGetItemResultSuccess extends CommunicationResult
{
  Communication communication;
  CommunicationGetItemResultSuccess(this.communication);
}

class CommunicationAddResultSuccess extends CommunicationResult {}

class CommunicationPutResultSuccess extends CommunicationResult
{
  Communication communication;
  CommunicationPutResultSuccess(this.communication);
}

class CommunicationDeleteResultSuccess extends CommunicationResult {}

class CommunicationResultFailure extends CommunicationResult
{
  final String error;
  CommunicationResultFailure(this.error);
}

// загрузка данных
class CommunicationResultLoading extends CommunicationResult { CommunicationResultLoading(); }