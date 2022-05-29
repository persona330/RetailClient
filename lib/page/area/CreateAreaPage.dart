import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/AreaController.dart';
import '../../model/Area.dart';

class CreateAreaPage extends StatefulWidget
{
  CreateAreaPage({Key? key}) : super(key: key);

  @override
  _CreateAreaPageState createState() => _CreateAreaPageState();
}

class _CreateAreaPageState extends StateMVC
{
  AreaController? _controller;

  _CreateAreaPageState() : super(AreaController()) {_controller = controller as AreaController;}

  final _nameController = TextEditingController();
  final _capacityController = TextEditingController();
  List<String> _storageConditionsList = ["storageConditions 1", "storageConditions 2"];
  List<String> _storeList = ["store 1", "store 2"];
  late String _storageConditions = _storageConditionsList[0];
  late String _store = _storeList[0];

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
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Вместимость"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _capacityController,
                  textInputAction: TextInputAction.next,
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Условия хранения",),
                    items: _storageConditionsList.map((String items){
                      return DropdownMenuItem(
                        child: Text(items.toString()),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item) { setState(() {_storageConditions = item!;}); }
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Склад",),
                    items: _storeList.map((String items){
                      return DropdownMenuItem(
                        child: Text(items.toString()),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item) { setState(() {_store = item!;}); }
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    //Address _address = Address(idAddress: 1, apartment:_apartmentController.text, entrance: int.parse(_entranceController.text), house: _houseController.text, street: _streetController.text, region: _regionController.text, city: _cityController.text, nation: _nationController.text);
                    //_controller?.addAddress(_address);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is AreaAddResultSuccess)
                    {
                      print("Все ок");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Добавлен")));
                    }
                    if (state is AreaResultLoading)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Загрузка")));
                    }
                    if (state is AreaResultFailure) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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