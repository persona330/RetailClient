import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';

import '../../controller/ImportController.dart';
import '../../model/Import.dart';

class CreateImportPage extends StatefulWidget
{
  CreateImportPage({Key? key}) : super(key: key);

  @override
  _CreateImportPageState createState() => _CreateImportPageState();
}

class _CreateImportPageState extends StateMVC
{
  ImportController? _controller;

  _CreateImportPageState() : super(ImportController()) {_controller = controller as ImportController;}

  final _quantityController = TextEditingController();
  final _costController = TextEditingController();
  final _vatController = TextEditingController();
  List<String> _consignmentNotelist = ["Накладная 1", "Накладная 2"];
  List<String> _nomenclatureList = ["Номенклатура 1", "Номенклатура 2"];
  late String _nomenclature = _nomenclatureList[0];
  late String _consignmentNote = _consignmentNotelist[0];

    @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    _quantityController.dispose();
    _costController.dispose();
    _vatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      appBar: AppBar(title: const Text('Создание привоза')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Количество"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _quantityController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Цена"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _costController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "НДС"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _vatController,
                  textInputAction: TextInputAction.next,
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Накладная",),
                    items: _consignmentNotelist.map((String items){
                      return DropdownMenuItem(
                        child: Text(items.toString()),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item)
                    {
                      setState(() {_consignmentNote = item!;});
                    }
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Номенклатура",),
                    items: _nomenclatureList.map((String items){
                      return DropdownMenuItem(
                        child: Text(items.toString()),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item)
                    {
                      setState(() {_nomenclature = item!;});
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
                    if (state is ImportAddResultSuccess)
                    {
                      print("Все ок");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Добавлен")));
                    }
                    if (state is ImportResultLoading)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Загрузка")));
                    }
                    if (state is ImportResultFailure) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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