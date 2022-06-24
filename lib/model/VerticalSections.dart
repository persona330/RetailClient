import 'package:decimal/decimal.dart';
import 'package:retail/model/Stillage.dart';

class VerticalSections
{
  final int? idVerticalSections;
  final String? number;
  final double? size;
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
      stillage: json["stillageDTO"] != null ? Stillage.fromJson(json["stillageDTO"]) : null,
      idVerticalSections: json["id_VerticalSections"],
    );
  }

  Map<String, dynamic> toJson() => {
    "number": number,
    "size": size,
    "stillageDTO": stillage == null ? null : stillage!.toJson(),
    "id_VerticalSections": idVerticalSections,
  };

  int? get getIdVerticalSections => idVerticalSections;
  String? get getNumber => number;
  double? get getSize => size;
  Stillage? get getStillage => stillage;

  @override
  String toString() {return '$number: вместисмость $size, стеллаж $stillage';}
}

abstract class VerticalSectionsResult {}

// указывает на успешный запрос
class VerticalSectionsGetListResultSuccess extends VerticalSectionsResult
{
  List<VerticalSections> verticalSectionsList = [];
  VerticalSectionsGetListResultSuccess(this.verticalSectionsList);
}

class VerticalSectionsGetItemResultSuccess extends VerticalSectionsResult
{
  VerticalSections verticalSections;
  VerticalSectionsGetItemResultSuccess(this.verticalSections);
}

class VerticalSectionsAddResultSuccess extends VerticalSectionsResult {}

class VerticalSectionsPutResultSuccess extends VerticalSectionsResult
{
  VerticalSections verticalSections;
  VerticalSectionsPutResultSuccess(this.verticalSections);
}

class VerticalSectionsDeleteResultSuccess extends VerticalSectionsResult {}

class VerticalSectionsResultFailure extends VerticalSectionsResult
{
  final String error;
  VerticalSectionsResultFailure(this.error);
}

// загрузка данных
class VerticalSectionsResultLoading extends VerticalSectionsResult { VerticalSectionsResultLoading(); }