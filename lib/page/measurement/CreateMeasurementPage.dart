import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';

import '../../controller/MeasurementController.dart';
import '../../model/Measurement.dart';

class CreateMeasurementPage extends StatefulWidget
{
  CreateMeasurementPage({Key? key}) : super(key: key);

  @override
  _CreateMeasurementPageState createState() => _CreateMeasurementPageState();
}

class _CreateMeasurementPageState extends StateMVC
{
  MeasurementController? _controller;

  _CreateMeasurementPageState() : super(AddressController()) {_controller = controller as MeasurementController;}

  final _nameController = TextEditingController();
  final _fullNameController = TextEditingController();

    @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    _nameController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      appBar: AppBar(title: const Text('Создание единицы измерения')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Сокращение"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Полное название"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _fullNameController,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Measurement _measurement = Measurement(idMeasurement: 1, name: _nameController.text, fullName: _fullNameController.text);
                    _controller?.addMeasurement(_measurement);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is MeasurementAddResultSuccess)
                    {
                      print("Все ок");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Добавлен")));
                    }
                    if (state is MeasurementResultLoading)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Загрузка")));
                    }
                    if (state is MeasurementResultFailure) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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