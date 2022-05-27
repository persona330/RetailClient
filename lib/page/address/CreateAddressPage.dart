import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';

class CreateAddressPage extends StatefulWidget
{
  CreateAddressPage({Key? key}) : super(key: key);

  @override
  _CreateAddressPageState createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends StateMVC
{
  AddressController? _controller;

  _CreateAddressPageState() : super(AddressController()) {_controller = controller as AddressController;}

  final _apartmentController = TextEditingController();
  final _entranceController = TextEditingController();
  final _houseController = TextEditingController();
  final _streetController = TextEditingController();
  final _regionController = TextEditingController();
  final _cityController = TextEditingController();
  final _nationController = TextEditingController();

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
    _houseController.dispose();
    _streetController.dispose();
    _regionController.dispose();
    _cityController.dispose();
    _nationController.dispose();
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
                  decoration: const InputDecoration(labelText: "Номер квартиры"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _apartmentController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Номер подъезда"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _entranceController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Номер дома"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _houseController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Название улицы"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _streetController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я]")),],
                  decoration: const InputDecoration(labelText: "Наименование региона"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _regionController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Название населенного пункта"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _cityController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я]")),],
                  decoration: const InputDecoration(labelText: "Наименование страны"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _nationController,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Address _address = Address(idAddress: UniqueKey().hashCode, apartment:_apartmentController.text, entrance: int.parse(_entranceController.text), house: _houseController.text, street: _streetController.text, region: _regionController.text, city: _cityController.text, nation: _nationController.text);
                    _controller?.addAddress(_address);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is AddressAddResultSuccess)
                    {
                      print("Все ок");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Добавлен")));
                    }
                    if (state is AddressResultLoading)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Загрузка")));
                    }
                    if (state is AddressResultFailure) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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