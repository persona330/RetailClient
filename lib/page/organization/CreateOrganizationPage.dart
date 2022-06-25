import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/organization/widget/CreateListAddressWidget.dart';
import '../../controller/OrganizationController.dart';
import '../../model/Communication.dart';
import '../../model/Organization.dart';
import '../address/CreateAddressPage.dart';
import 'GetAllOrganizationPage.dart';
import 'widget/CreateListCommunicationWidget.dart';

class CreateOrganizationPage extends StatefulWidget
{
  const CreateOrganizationPage({Key? key}) : super(key: key);

  @override
  _CreateOrganizationPageState createState() => _CreateOrganizationPageState();

  static _CreateOrganizationPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateOrganizationPageState? result =
    context.findAncestorStateOfType<_CreateOrganizationPageState>();
    return result;
  }
}

class _CreateOrganizationPageState extends StateMVC
{
  OrganizationController? _controller;

  _CreateOrganizationPageState() : super(OrganizationController()) {_controller = controller as OrganizationController;}

  final _nameController = TextEditingController();
  final _innController = TextEditingController();
  final _kppController = TextEditingController();

  late Communication communication;
  late Address address;

  @override
  void initState()
  {
    super.initState();
  }

  Address getAddress() { return address; }
  void setAddress(Address address) { this.address = address; }

  Communication getCommunication() { return communication; }
  void setCommunication(Communication communication) { this.communication = communication; }

  @override
  void dispose()
  {
    _nameController.dispose();
    _innController.dispose();
    _kppController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
      return Scaffold(
        appBar: AppBar(title: const Text('Создание организации')),
        body: Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Название"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Номер ИНН"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _innController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Номер КПП"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _kppController,
                  textInputAction: TextInputAction.next,
                ),
                Row(
                  children: [
                  const Flexible(
                  flex: 1,
                  child: CreateListAddressWidget(),
                ),
                OutlinedButton(
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAddressPage()));
                  },
                  child: const Text('Добавить'),
                ),
                  ],
                ),
                const Flexible(
                  flex: 1,
                  child: CreateListAddressWidget(),
                ),
                const Flexible(
                    flex: 2,
                    child: CreateListCommunicationWidget()
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                      Organization organization = Organization(
                        idOrganization: UniqueKey().hashCode,
                        name: _nameController.text,
                        address: getAddress(),
                        communication: getCommunication(),
                        inn: _innController.text,
                        kpp: _kppController.text);
                      _controller?.addOrganization(organization);
                      GetAllOrganizationPage.of(context)?.refresh();
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is OrganizationAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Организация создана")));}
                      if (state is OrganizationResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is OrganizationResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении организации")));}
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