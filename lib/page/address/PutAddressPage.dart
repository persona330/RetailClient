import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';

class PutAddressPage extends StatefulWidget
{
  final int id;
  const PutAddressPage({Key? key, required this.id}) : super(key: key);

  @override
  PutAddressPageState createState() => PutAddressPageState(id);
}

class PutAddressPageState extends StateMVC
{
  AddressController? _controller;
  final int _id;

  PutAddressPageState(this._id) : super(AddressController()) {_controller = controller as AddressController;}

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
    _controller?.getAddress(_id);
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
    final state = _controller?.currentState;
    if (state is AddressResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is AddressResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _address = (state as AddressGetItemResultSuccess).address;
      _apartmentController.text = _address.getApartment!;
      _entranceController.text = _address.getEntrance!.toString();
      _houseController.text = _address.getHouse!;
      _streetController.text = _address.getStreet!;
      _regionController.text = _address.getRegion!;
      _cityController.text = _address.getCity!;
      _nationController.text = _address.getNation!;
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение адреса')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                    decoration: const InputDecoration(labelText: "Номер квартиры"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _apartmentController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(labelText: "Номер подъезда"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _entranceController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                    decoration: const InputDecoration(labelText: "Номер дома"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _houseController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                    decoration: const InputDecoration(labelText: "Название улицы"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _streetController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я]")),],
                    decoration: const InputDecoration(labelText: "Наименование региона"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _regionController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                    decoration: const InputDecoration(labelText: "Название населенного пункта"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _cityController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я]")),],
                    decoration: const InputDecoration(labelText: "Наименование страны"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _nationController,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Address _address1 = Address(idAddress: _id,
                          apartment: _apartmentController.text,
                          entrance: int.parse(_entranceController.text),
                          house: _houseController.text,
                          street: _streetController.text,
                          region: _regionController.text,
                          city: _cityController.text,
                          nation: _nationController.text);
                      _controller?.putAddress(_address1, _id);
                      Navigator.pop(context, true);
                      if (state is AddressPutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Адрес изменен")));}
                      if (state is AddressResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is AddressResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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