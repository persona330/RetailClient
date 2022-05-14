import 'package:decimal/decimal.dart';

class Box
{
  final int? idBox;
  final String? number;
  final Decimal? size;
  //final Shelf? shelf;
  //final VerticalSections? verticalSections;

  Box({
    required this.idBox,
    required this.number,
    required this.size,
    //required this.shelf,
    //required this.verticalSections,
  });

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      number: json["number"],
      size: json["size"],
      //shelf: json["shelf"],
      //verticalSections: json["verticalSections"],
      idBox: json["id_Box"],
    );
  }

  Map<String, dynamic> toJson() => {
    "number": number,
    "size": size,
    //"shelf": shelf,
    //"verticalSections": verticalSections,
    "id_Box": idBox,
  };

  int? get getIdBox => idBox;
  String? get getNumber => number;
  Decimal? get getSize => size;
  //Shelf? get getShelf => shelf;
  //VerticalSections? get getVerticalSections => verticalSections;
}

abstract class BoxResult {}

// указывает на успешный запрос
class BoxGetListResultSuccess extends BoxResult
{
  List<Box> boxList = [];
  BoxGetListResultSuccess(this.boxList);
}

class BoxGetItemResultSuccess extends BoxResult
{
  Box box;
  BoxGetItemResultSuccess(this.box);
}

class BoxAddResultSuccess extends BoxResult {}

class BoxPutResultSuccess extends BoxResult
{
  Box box;
  BoxPutResultSuccess(this.box);
}

class BoxDeleteResultSuccess extends BoxResult {}

class BoxResultFailure extends BoxResult
{
  final String error;
  BoxResultFailure(this.error);
}

// загрузка данных
class BoxResultLoading extends BoxResult { BoxResultLoading(); }