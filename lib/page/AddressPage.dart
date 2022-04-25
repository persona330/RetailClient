import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';

class AddressPage extends StatefulWidget
{
  AddressPage({Key? key}) : super(key: key);

  @override
  _CreateAddressPage createState() => _CreateAddressPage();
}

class _CreateAddressPage extends State<AddressPage>
{
  final AddressService _addressService = AddressService();

  final _apartmentController = TextEditingController();
  final _entranceController = TextEditingController();
  final _houseController = TextEditingController();
  final _streetController = TextEditingController();
  final _regionController = TextEditingController();
  final _cityController = TextEditingController();
  final _nationController = TextEditingController();

  final int _idAddress = 3;
  late String _apartment = "1";
  late String _entrance = "0";
  late String _house = "107а";
  late String _street = "Карла Маркса";
  late String _region = "Курганский";
  late String _city = "Курган";
  late String _nation = "Россия";


  _changeApartment() { setState(() => _apartment = _apartmentController.text); }
  _changeEntrance()
  {
    setState(() => _entrance = _entranceController.text);
   // print(int.parse(_entrance));
  }
  _changeHouse() {setState(() => _house = _houseController.text);}
  _changeStreet() { setState(() => _street = _streetController.text); }
  _changeRegion() { setState(() => _region = _regionController.text); }
  _changeCity() { setState(() => _city = _cityController.text); }
  _changeNation() { setState(() => _nation = _nationController.text); }

    @override
  void initState()
  {
    super.initState();
    _apartmentController.addListener(_changeApartment);
    _entranceController.addListener(_changeEntrance);
    _houseController.addListener(_changeHouse);
    _streetController.addListener(_changeStreet);
    _regionController.addListener(_changeRegion);
    _cityController.addListener(_changeCity);
    _nationController.addListener(_changeNation);
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
      appBar: AppBar(title: Text('Создание адреса')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
            padding: EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                Text("Адрес: $_apartment, $_entrance, $_house, $_street, $_region, $_city, $_nation", style: TextStyle(fontSize: 14)),
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
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    print("Адрес: $_apartment, $_entrance, $_house, $_street, $_region, $_city, $_nation");
                    var _entInt = int.parse(_entrance);
                    assert(_entInt is int);
                    Address address = Address(idAddress: _idAddress, apartment: _apartment, entrance: _entInt, house: _house, street: _street, region: _region, city: _city, nation: _nation);
                    //Address address = Address(idAddress: 3, apartment: "12a", entrance: 1, house: "12", street: "ghj", region: "gjg", city: "fhgfh", nation: "jhl");
                    _addressService.addAddress(address);
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