import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/store/widget/PutListAddressWidget.dart';
import 'package:retail/page/store/widget/PutListOrganizationWidget.dart';

import '../../controller/StoreController.dart';
import '../../model/Organization.dart';
import '../../model/Store.dart';

class PutStorePage extends StatefulWidget
{
  final int id;
  const PutStorePage({Key? key, required this.id}) : super(key: key);

  @override
  PutStorePageState createState() => PutStorePageState(id);

  static PutStorePageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutStorePageState? result =
    context.findAncestorStateOfType<PutStorePageState>();
    return result;
  }
}

class PutStorePageState extends StateMVC
{
  StoreController? _controller;
  final int _id;

  PutStorePageState(this._id) : super(StoreController()) {_controller = controller as StoreController;}

  final _nameController = TextEditingController();
  final _totalCapacityController = TextEditingController();

  late Organization _organization;
  late Address _address;

  Organization getOrganization(){return _organization;}
  void setOrganization(Organization organization){_organization = organization;}

  Address getAddress(){ return _address;}
  void setAddress(Address address){_address = address; }

  @override
  void initState()
  {
    super.initState();
    _controller?.getStore(_id);
  }

  @override
  void dispose()
  {
    _nameController.dispose();
    _totalCapacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is StoreResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StoreResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _store = (state as StoreGetItemResultSuccess).store;
      _nameController.text = _store.getName!;
      _totalCapacityController.text = _store.getTotalCapacity!.toString();
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение склада')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                    decoration: const InputDecoration(labelText: "Номер склада"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(labelText: "Полная вместимость"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _totalCapacityController,
                    textInputAction: TextInputAction.next,
                  ),
                  const Flexible(
                    flex: 1,
                    child: PutListAddressWidget(),
                  ),
                  const Flexible(
                      flex: 2,
                      child: PutListOrganizationWidget()
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Store _store1 = Store(idStore: _id, name: _nameController.text, totalCapacity: double.parse(_totalCapacityController.text), organization: getOrganization(), address: getAddress());
                      _controller?.putStore(_store1, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is StorePutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Склад изменен")));}
                      if (state is StoreResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is StoreResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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