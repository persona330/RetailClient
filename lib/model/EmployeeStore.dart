class EmployeeStore
{
  final int? idEmployeeStore;
  //final Position? position;
  //final Organization? organization;

  EmployeeStore({
    required this.idEmployeeStore,
    //required this.position,
    //required this.organization,
  });

  factory EmployeeStore.fromJson(Map<String, dynamic> json) {
    return EmployeeStore(
      //position: json["position"],
      //organization: json["organization"],
      idEmployeeStore: json["id_EmployeeStore"],
    );
  }

  Map<String, dynamic> toJson() => {
    //"position": position,
    //"organization": organization,
    "id_EmployeeStore": idEmployeeStore,
  };

  int? get getIdEmployeeStore=> idEmployeeStore;
  //Position? get getPosition => position;
  //Organization? get getOrganization => organization;
}

abstract class EmployeeStoreResult {}

// указывает на успешный запрос
class EmployeeStoreGetListResultSuccess extends EmployeeStoreResult
{
  List<EmployeeStore> employeeStoreList = [];
  EmployeeStoreGetListResultSuccess(this.employeeStoreList);
}

class EmployeeStoreGetItemResultSuccess extends EmployeeStoreResult
{
  EmployeeStore employeeStore;
  EmployeeStoreGetItemResultSuccess(this.employeeStore);
}

class EmployeeStoreAddResultSuccess extends EmployeeStoreResult {}

class EmployeeStorePutResultSuccess extends EmployeeStoreResult
{
  EmployeeStore employeeStore;
  EmployeeStorePutResultSuccess(this.employeeStore);
}

class EmployeeStoreDeleteResultSuccess extends EmployeeStoreResult {}

class EmployeeStoreResultFailure extends EmployeeStoreResult
{
  final String error;
  EmployeeStoreResultFailure(this.error);
}

// загрузка данных
class EmployeeStoreResultLoading extends EmployeeStoreResult { EmployeeStoreResultLoading(); }