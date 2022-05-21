import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';

import '../../controller/MeasurementController.dart';
import '../../model/Measurement.dart';

class PutMeasurementPage extends StatefulWidget
{
  final int id;
  const PutMeasurementPage({Key? key, required this.id}) : super(key: key);

  @override
  PutMeasurementPageState createState() => PutMeasurementPageState(id);
}

class PutMeasurementPageState extends StateMVC
{
  MeasurementController? _controller;
  final int _id;

  PutMeasurementPageState(this._id) : super(MeasurementController()) {_controller = controller as MeasurementController;}

  final _nameController = TextEditingController();
  final _fullNameController = TextEditingController();

  @override
  void initState()
  {
    super.initState();
    _controller?.getMeasurement(_id);
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
    final state = _controller?.currentState;
    if (state is MeasurementResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is MeasurementResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _measurement = (state as MeasurementGetItemResultSuccess).measurement;
      _nameController.text = _measurement.getName!;
      _fullNameController.text = _measurement.getFullName!;
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение единицы измерения')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Zа-яА-Я0-9]")),
                    ],
                    decoration: const InputDecoration(
                        labelText: "Сокращенное название"),
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        labelText: "Полное название"),
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _fullNameController,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Measurement _measurement1 = Measurement(idMeasurement: _id,
                          name: _nameController.text,
                          fullName: _fullNameController.text,);
                      _controller?.putMeasurement(_measurement1, _id);
                      Navigator.pop(context, true);
                      if (state is MeasurementAddResultSuccess) {
                        print("Все ок");
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Добавлен")));
                      }
                      if (state is MeasurementResultLoading) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Загрузка")));
                      }
                      if (state is MeasurementResultFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                "Произошла ошибка при добавлении поста")));
                      }
                    },
                    child: const Text('Отправить'),
                  ),
                ]
            ),
          ),
        ),
      );
    }
  }

}