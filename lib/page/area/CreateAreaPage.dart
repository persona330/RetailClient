import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/StorageConditions.dart';
import 'package:retail/page/stillage/ListStillageWidget.dart';
import 'package:retail/page/store/ListStoreWidget.dart';
import '../../controller/AreaController.dart';
import '../../model/Area.dart';
import '../../model/Store.dart';
import '../storage_conditions/ListStorageConditionsWidget.dart';

class CreateAreaPage extends StatefulWidget
{
  const CreateAreaPage({Key? key}) : super(key: key);

  @override
  _CreateAreaPageState createState() => _CreateAreaPageState();

  static _CreateAreaPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateAreaPageState? result =
    context.findAncestorStateOfType<_CreateAreaPageState>();
    return result;
  }
}

class _CreateAreaPageState extends StateMVC
{
  AreaController? _controller;

  _CreateAreaPageState() : super(AreaController()) {_controller = controller as AreaController;}

  final _nameController = TextEditingController();
  final _capacityController = TextEditingController();

  late StorageConditions _storageConditions;
  late Store _store;

  StorageConditions getStorageConditions(){ return _storageConditions;}
  void setStorageConditions(StorageConditions storageConditions){ _storageConditions = storageConditions;}

  Store getStore(){ return _store;}
  void setStore(Store store){_store = store;}

    @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    _nameController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      appBar: AppBar(title: const Text('Создание зоны')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
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
                  decoration: const InputDecoration(labelText: "Вместимость"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _capacityController,
                  textInputAction: TextInputAction.next,
                ),
                const Flexible(
                  flex: 1,
                  child: ListStorageConditionsWidget(),
                ),
                const Flexible(
                    flex: 2,
                    child: ListStoreWidget()
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Area _area = Area(idArea: UniqueKey().hashCode, name: _nameController.text, capacity: double.parse(_capacityController.text), storageConditions: getStorageConditions(), store: getStore());
                    _controller?.addArea(_area);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is AreaAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Добавлен")));}
                    if (state is AreaResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is AreaResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Отправить'),
                ),
              ],
            ),
          ),
      ),
    );
  }
}