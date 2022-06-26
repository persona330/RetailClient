import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/model/Organization.dart';
import 'package:retail/page/store/widget/CreateListAddressWidget.dart';
import 'package:retail/page/store/widget/CreateListOrganizationWidget.dart';
import '../../controller/StoreController.dart';
import '../../model/Store.dart';

class CreateStorePage extends StatefulWidget
{
  const CreateStorePage({Key? key}) : super(key: key);

  @override
  _CreateStorePageState createState() => _CreateStorePageState();

  static _CreateStorePageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateStorePageState? result =
    context.findAncestorStateOfType<_CreateStorePageState>();
    return result;
  }
}

class _CreateStorePageState extends StateMVC
{
  StoreController? _controller;

  _CreateStorePageState() : super(StoreController()) {_controller = controller as StoreController;}

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
    return Scaffold(
      appBar: AppBar(title: const Text('Создание склада')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
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
                  child: CreateListAddressWidget(),
                ),
                const Flexible(
                    flex: 2,
                    child: CreateListOrganizationWidget()
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Store _store = Store(idStore: UniqueKey().hashCode, name: _nameController.text, totalCapacity: double.parse(_totalCapacityController.text), organization: getOrganization(), address: getAddress());
                    _controller?.addStore(_store);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is StoreAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Склад создан")));}
                    if (state is StoreResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is StoreResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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