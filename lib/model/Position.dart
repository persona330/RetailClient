class Position
{
  final int? idPosition;
  final String? name;

  Position({
    required this.idPosition,
    required this.name,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      name: json["name"],
      idPosition: json["id_Position"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "id_Position": idPosition,
  };

  int? get getIdPosition => idPosition;
  String? get getName => name;

  @override
  String toString() {
    return '$name';
  }
}

abstract class PositionResult {}

// указывает на успешный запрос
class PositionGetListResultSuccess extends PositionResult
{
  List<Position> positionList = [];
  PositionGetListResultSuccess(this.positionList);
}

class PositionGetItemResultSuccess extends PositionResult
{
  Position position;
  PositionGetItemResultSuccess(this.position);
}

class PositionAddResultSuccess extends PositionResult {}

class PositionPutResultSuccess extends PositionResult
{
  Position position;
  PositionPutResultSuccess(this.position);
}

class PositionDeleteResultSuccess extends PositionResult {}

class PositionResultFailure extends PositionResult
{
  final String error;
  PositionResultFailure(this.error);
}

// загрузка данных
class PositionResultLoading extends PositionResult { PositionResultLoading(); }