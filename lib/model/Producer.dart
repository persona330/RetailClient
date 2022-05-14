class Producer
{
  final int? idProducer;
  final String? name;

  Producer({
    required this.idProducer,
    required this.name,
  });

  factory Producer.fromJson(Map<String, dynamic> json) {
    return Producer(
      name: json["name"],
      idProducer: json["id_Producer"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "id_Producer": idProducer,
  };

  int? get getIdProducer => idProducer;
  String? get getName => name;
}

abstract class ProducerResult {}

// указывает на успешный запрос
class ProducerGetListResultSuccess extends ProducerResult
{
  List<Producer> producerList = [];
  ProducerGetListResultSuccess(this.producerList);
}

class ProducerGetItemResultSuccess extends ProducerResult
{
  Producer producer;
  ProducerGetItemResultSuccess(this.producer);
}

class ProducerAddResultSuccess extends ProducerResult {}

class ProducerPutResultSuccess extends ProducerResult
{
  Producer producer;
  ProducerPutResultSuccess(this.producer);
}

class ProducerDeleteResultSuccess extends ProducerResult {}

class ProducerResultFailure extends ProducerResult
{
  final String error;
  ProducerResultFailure(this.error);
}

// загрузка данных
class ProducerResultLoading extends ProducerResult { ProducerResultLoading(); }