import 'package:decimal/decimal.dart';
import 'package:retail/model/Stillage.dart';

class VerticalSections
{
  final int? idVerticalSections;
  final String? number;
  final Decimal? size;
  final Stillage? stillage;

  VerticalSections({
    required this.idVerticalSections,
    required this.number,
    required this.size,
    required this.stillage,
  });

  factory VerticalSections.fromJson(Map<String, dynamic> json) {
    return VerticalSections(
      number: json["number"],
      size: json["size"],
      stillage: json["stillage"],
      idVerticalSections: json["id_VerticalSections"],
    );
  }

  Map<String, dynamic> toJson() => {
    "number": number,
    "size": size,
    "stillage": stillage,
    "id_VerticalSections": idVerticalSections,
  };

  int? get getIdVerticalSections => idVerticalSections;
  String? get getNumber => number;
  Decimal? get getSize => size;
  Stillage? get getStillage => stillage;
}

abstract class VerticalSectionsResult {}

// указывает на успешный запрос
class VerticalSectionsGetListResultSuccess extends VerticalSectionsResult
{
  List<VerticalSections> addressList = [];
  VerticalSectionsGetListResultSuccess(this.addressList);
}

class VerticalSectionsGetItemResultSuccess extends VerticalSectionsResult
{
  VerticalSections address;
  VerticalSectionsGetItemResultSuccess(this.address);
}

class VerticalSectionsAddResultSuccess extends VerticalSectionsResult {}

class VerticalSectionsPutResultSuccess extends VerticalSectionsResult
{
  VerticalSections address;
  VerticalSectionsPutResultSuccess(this.address);
}

class VerticalSectionsDeleteResultSuccess extends VerticalSectionsResult {}

class VerticalSectionsResultFailure extends VerticalSectionsResult
{
  final String error;
  VerticalSectionsResultFailure(this.error);
}

// загрузка данных
class VerticalSectionsResultLoading extends VerticalSectionsResult { VerticalSectionsResultLoading(); }