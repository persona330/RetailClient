import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/employee_store/widget/PutListOrganizationWidget.dart';
import 'package:retail/page/employee_store/widget/PutListPositionWidget.dart';
import '../../controller/EmployeeStoreController.dart';
import '../../model/Communication.dart';
import '../../model/EmployeeStore.dart';
import '../../model/Organization.dart';
import '../../model/Position.dart';
import '../organization/widget/PutListAddressWidget.dart';
import '../organization/widget/PutListCommunicationWidget.dart';

class PutEmployeeStorePage extends StatefulWidget
{
  final int id;
  const PutEmployeeStorePage({Key? key, required this.id}) : super(key: key);

  @override
  PutEmployeeStorePageState createState() => PutEmployeeStorePageState(id);

  static PutEmployeeStorePageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutEmployeeStorePageState? result =
    context.findAncestorStateOfType<PutEmployeeStorePageState>();
    return result;
  }
}

class PutEmployeeStorePageState extends StateMVC
{
  EmployeeStoreController? _controller;
  final int _id;

  PutEmployeeStorePageState(this._id) : super(EmployeeStoreController()) {_controller = controller as EmployeeStoreController;}

  final _surnameController = TextEditingController();
  final _nameController = TextEditingController();
  final _patronymicController = TextEditingController();
  late bool _free = false;
  late Communication _communication;
  late Address _address;
  late Organization _organization;
  late Position _position;

  Address getAddress() { return _address; }
  void setAddress(Address address) { _address = address; }

  Communication getCommunication() { return _communication; }
  void setCommunication(Communication communication) { _communication = communication; }

  Organization getOrganization() { return _organization; }
  void setOrganization(Organization organization) { _organization = organization; }

  Position getPosition() { return _position; }
  void setPosition(Position position) { _position = position; }

  @override
  void initState()
  {
    super.initState();
    _controller?.getEmployeeStore(_id);
  }

  @override
  void dispose()
  {
    _surnameController.dispose();
    _nameController.dispose();
    _patronymicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is EmployeeStoreResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is EmployeeStoreResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _employeeStore = (state as EmployeeStoreGetItemResultSuccess).employeeStore;
      _surnameController.text = _employeeStore.getSurname!;
      _nameController.text = _employeeStore.getName!;
      _patronymicController.text = _employeeStore.getPatronymic!;
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение сотрудника склада')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я]")),],
                    decoration: const InputDecoration(labelText: "Фамилия"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _surnameController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я]")),],
                    decoration: const InputDecoration(labelText: "Имя"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я]")),],
                    decoration: const InputDecoration(labelText: "Отчество"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _patronymicController,
                    textInputAction: TextInputAction.next,
                  ),
                  Row(
                    children: [
                      const Text("Свободен", style: TextStyle(fontSize: 14, color: Colors.blue)),
                      Checkbox(
                          value: _free,
                          onChanged: (value) async { setState(() {_free = value!;});}
                      ),
                    ],
                  ),
                  const Flexible(
                    flex: 1,
                    child: PutListAddressWidget(),
                  ),
                  const Flexible(
                    flex: 2,
                    child: PutListCommunicationWidget(),
                  ),
                  const Flexible(
                    flex: 3,
                    child: PutListOrganizationWidget(),
                  ),const Flexible(
                    flex: 4,
                    child: PutListPositionWidget(),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: ()
                    {
                      EmployeeStore _employeeStore1 = EmployeeStore(id: _id, surname: _surnameController.text, name: _nameController.text, patronymic: _patronymicController.text, address: getAddress(), communication: getCommunication(), free: _free, organization: getOrganization(), position: getPosition());
                      _controller?.putEmployeeStore(_employeeStore1, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is EmployeeStorePutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Сотрудник склада изменен")));}
                      if (state is EmployeeStoreResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is EmployeeStoreResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}

                    },
                    child: const Text('Изменить'),
                  ),
                ]
            ),
          ),
        ),
      );
    }
  }

}