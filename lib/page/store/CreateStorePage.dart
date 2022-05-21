import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';

import '../../controller/StoreController.dart';
import '../../model/Store.dart';

class CreateStorePage extends StatefulWidget
{
  CreateStorePage({Key? key}) : super(key: key);

  @override
  _CreateStorePageState createState() => _CreateStorePageState();
}

class _CreateStorePageState extends StateMVC
{
  StoreController? _controller;


  _CreateStorePageState() : super(StoreController()) {_controller = controller as StoreController;}

  final _apartmentController = TextEditingController();
  final _entranceController = TextEditingController();

  var items1 = ["Организация 1", "Организация 2", "Организация 3"];
  var items2 = ["Адрес 1", "Адрес 2", "Адрес 3"];
  String organization = "Организация 1";
  String address = "Адрес 1";

    @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    _apartmentController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      appBar: AppBar(title: const Text('Создание адреса')),
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
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _apartmentController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Полная вместимость"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _entranceController,
                  textInputAction: TextInputAction.next,
                ),
                DropdownButton(
                    isExpanded: true,
                    disabledHint: Text("Организация"),
                    value: organization,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items1.map((String items){
                      return DropdownMenuItem(
                        child: Text(items),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item)
                    {
                      setState(() {organization = item!;});
                    }
                ),
                DropdownButton(
                    isExpanded: true,
                    disabledHint: Text("Адрес"),
                    value: address,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items2.map((String items){
                      return DropdownMenuItem(
                        child: Text(items),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item)
                    {
                      setState(() {address = item!;});
                    }
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    //Address _address = Address(idAddress: 1, apartment:_apartmentController.text, entrance: int.parse(_entranceController.text), house: _houseController.text, street: _streetController.text, region: _regionController.text, city: _cityController.text, nation: _nationController.text);
                    //_controller?.addAddress(_address);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is StoreAddResultSuccess)
                    {
                      print("Все ок");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Добавлен")));
                    }
                    if (state is StoreResultLoading)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Загрузка")));
                    }
                    if (state is StoreResultFailure) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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