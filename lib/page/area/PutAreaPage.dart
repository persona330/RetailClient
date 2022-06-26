import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/area/widget/PutListStorageConditionsWidget.dart';
import 'package:retail/page/area/widget/PutListStoreWidget.dart';
import '../../controller/AreaController.dart';
import '../../model/Area.dart';
import '../../model/StorageConditions.dart';
import '../../model/Store.dart';

class PutAreaPage extends StatefulWidget
{
  final int id;
  const PutAreaPage({Key? key, required this.id}) : super(key: key);

  @override
  PutAreaPageState createState() => PutAreaPageState(id);

  static PutAreaPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutAreaPageState? result =
    context.findAncestorStateOfType<PutAreaPageState>();
    return result;
  }
}

class PutAreaPageState extends StateMVC
{
  AreaController? _controller;
  final int _id;

  PutAreaPageState(this._id) : super(AreaController()) {_controller = controller as AreaController;}

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
    _controller?.getArea(_id);
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
    final state = _controller?.currentState;
    if (state is AreaResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is AreaResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _area = (state as AreaGetItemResultSuccess).area;
      _nameController.text = _area.getName!;
      _capacityController.text = _area.getCapacity!.toString();
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение зоны')),
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
                    decoration: const InputDecoration(labelText: "Вместимость"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _capacityController,
                    textInputAction: TextInputAction.next,
                  ),
                  const Flexible(
                    flex: 1,
                    child: PutListStorageConditionsWidget(),
                  ),
                  const Flexible(
                      flex: 2,
                      child: PutListStoreWidget()
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Area _area1 = Area(idArea: _id, name: _nameController.text, capacity: double.parse(_capacityController.text), storageConditions: getStorageConditions(), store: getStore());
                      _controller?.putArea(_area1, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is AreaPutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Зона изменена")));}
                      if (state is AreaResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is AreaResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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