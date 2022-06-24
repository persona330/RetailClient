class Group
{
  final int? idGroup;
  final String? name;
  final Group? type;

  Group({
    required this.idGroup,
    required this.name,
    required this.type,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      name: json["name"],
      type: json["type"] != null ? Group.fromJson(json["type"]) : null,
      idGroup: json["id_Group"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type == null ? null : type!.toJson(),
    "id_Group": idGroup,
  };

  int? get getIdGroup => idGroup;
  String? get getName => name;
  Group? get getType => type;

  @override
  String toString() {return '$name: тип $type';}
}

abstract class GroupResult {}

// указывает на успешный запрос
class GroupGetListResultSuccess extends GroupResult
{
  List<Group> groupList = [];
  GroupGetListResultSuccess(this.groupList);
}

class GroupGetItemResultSuccess extends GroupResult
{
  Group group;
  GroupGetItemResultSuccess(this.group);
}

class GroupAddResultSuccess extends GroupResult {}

class GroupPutResultSuccess extends GroupResult
{
  Group group;
  GroupPutResultSuccess(this.group);
}

class GroupDeleteResultSuccess extends GroupResult {}

class GroupResultFailure extends GroupResult
{
  final String error;
  GroupResultFailure(this.error);
}

class GroupResultLoading extends GroupResult { GroupResultLoading(); }