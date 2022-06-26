import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/organization/widget/PutListAddressWidget.dart';
import 'package:retail/page/organization/widget/PutListCommunicationWidget.dart';
import '../../controller/OrganizationController.dart';
import '../../model/Communication.dart';
import '../../model/Organization.dart';

class PutOrganizationPage extends StatefulWidget
{
  final int id;
  const PutOrganizationPage({Key? key, required this.id}) : super(key: key);

  @override
  PutOrganizationPageState createState() => PutOrganizationPageState(id);

  static PutOrganizationPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutOrganizationPageState? result =
    context.findAncestorStateOfType<PutOrganizationPageState>();
    return result;
  }
}

class PutOrganizationPageState extends StateMVC
{
  OrganizationController? _controller;
  final int _id;

  PutOrganizationPageState(this._id) : super(OrganizationController()) {_controller = controller as OrganizationController;}

  final _nameController = TextEditingController();
  final _innController = TextEditingController();
  final _kppController = TextEditingController();

  late Communication _communication;
  late Address _address;

  Address getAddress() { return _address; }
  void setAddress(Address address) { _address = address; }

  Communication getCommunication() { return _communication; }
  void setCommunication(Communication communication) { _communication = communication; }

  @override
  void initState()
  {
    super.initState();
    _controller?.getOrganization(_id);
  }

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
    final state = _controller?.currentState;
    if (state is OrganizationResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is OrganizationResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _organization = (state as OrganizationGetItemResultSuccess).organization;
      _nameController.text = _organization.getName!;
      _innController.text = _organization.getInn!;
      _kppController.text = _organization.getKpp!;
      _address = _organization.getAddress!;
      _communication = _organization.getCommunication!;
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение организации')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9\s]")),],
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
                  const Flexible(
                    flex: 1,
                    child: PutListAddressWidget(),
                  ),
                  const Flexible(
                      flex: 2,
                      child: PutListCommunicationWidget()
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Organization _organization1 = Organization(
                          idOrganization: _id,
                          name: _nameController.text,
                          address: getAddress(),
                          communication: getCommunication(),
                          inn: _innController.text,
                          kpp: _kppController.text);
                      _controller?.putOrganization(_organization1, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is OrganizationPutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Организация изменена")));}
                      if (state is OrganizationResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is OrganizationResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при обновлении организации")));}
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