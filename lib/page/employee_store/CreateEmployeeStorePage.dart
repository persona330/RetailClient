import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Organization.dart';
import 'package:retail/model/Position.dart';
import 'package:retail/page/employee_store/widget/CreateListAddressWidget.dart';
import 'package:retail/page/employee_store/widget/CreateListCommunicationWidget.dart';
import 'package:retail/page/employee_store/widget/CreateListOrganizationWidget.dart';
import 'package:retail/page/employee_store/widget/CreateListPositionWidget.dart';
import '../../controller/EmployeeStoreController.dart';
import '../../model/Address.dart';
import '../../model/Communication.dart';
import '../../model/EmployeeStore.dart';

class CreateEmployeeStorePage extends StatefulWidget
{
  const CreateEmployeeStorePage({Key? key}) : super(key: key);

  @override
  _CreateEmployeeStorePageState createState() => _CreateEmployeeStorePageState();

  static _CreateEmployeeStorePageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateEmployeeStorePageState? result =
    context.findAncestorStateOfType<_CreateEmployeeStorePageState>();
    return result;
  }
}

class _CreateEmployeeStorePageState extends StateMVC
{
  EmployeeStoreController? _controller;

  _CreateEmployeeStorePageState() : super(EmployeeStoreController()) {_controller = controller as EmployeeStoreController;}

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
  }

  @override
  void dispose()
  {
    _nameController.dispose();
    _surnameController.dispose();
    _patronymicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text('Создание сотрудника склада')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
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
                  child: CreateListAddressWidget(),
                ),
                const Flexible(
                  flex: 2,
                  child: CreateListCommunicationWidget(),
                ),
                const Flexible(
                  flex: 3,
                  child: CreateListOrganizationWidget(),
                ),const Flexible(
                  flex: 4,
                  child: CreateListPositionWidget(),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    EmployeeStore _employeeStore = EmployeeStore(id: UniqueKey().hashCode, surname: _surnameController.text, name: _nameController.text, patronymic: _patronymicController.text, address: getAddress(), communication: getCommunication(), free: _free, organization: getOrganization(), position: getPosition());
                    _controller?.addEmployeeStore(_employeeStore);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is EmployeeStoreAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Сотрудник склада создан")));}
                    if (state is EmployeeStoreResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is EmployeeStoreResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Создать'),
                ),
              ],
            ),
          ),
      ),
    );
  }
}