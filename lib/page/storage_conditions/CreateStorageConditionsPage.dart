import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/measurement/ListMeasurementWidget.dart';
import '../../controller/StorageConditionsController.dart';
import '../../model/Measurement.dart';
import '../../model/StorageConditions.dart';

class CreateStorageConditionsPage extends StatefulWidget
{
  const CreateStorageConditionsPage({Key? key}) : super(key: key);

  @override
  _CreateStorageConditionsPageState createState() => _CreateStorageConditionsPageState();

  static _CreateStorageConditionsPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateStorageConditionsPageState? result =
    context.findAncestorStateOfType<_CreateStorageConditionsPageState>();
    return result;
  }
}

class _CreateStorageConditionsPageState extends StateMVC
{
  StorageConditionsController? _controller;

  _CreateStorageConditionsPageState() : super(StorageConditionsController()) {_controller = controller as StorageConditionsController;}

  final _nameController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _humidityController = TextEditingController();
  final _illuminationController = TextEditingController();
  late Measurement _measurementTemperature;
  late Measurement _measurementHumidity;
  late Measurement _measurementIllumination;

  Measurement getMeasurementTemperature(){return _measurementTemperature;}
  void setMeasurementTemperature(Measurement measurement){_measurementTemperature = measurement;}

  Measurement getMeasurementHumidity(){return _measurementHumidity;}
  void setMeasurementHumidity(Measurement measurement){_measurementHumidity = measurement;}

  Measurement getMeasurementIllumination(){return _measurementIllumination;}
  void setMeasurementIllumination(Measurement measurement){_measurementIllumination = measurement;}


    @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    _nameController.dispose();
    _temperatureController.dispose();
    _humidityController.dispose();
    _illuminationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      appBar: AppBar(title: const Text('Создание условий хранения')),
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
                  decoration: const InputDecoration(labelText: "Температура"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _temperatureController,
                  textInputAction: TextInputAction.next,
                ),
                const Flexible(
                  flex: 1,
                  child: ListMeasurementWidget(),
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Влажность"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _humidityController,
                  textInputAction: TextInputAction.next,
                ),
                const Flexible(
                    flex: 2,
                    child: ListMeasurementWidget()
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Освещение"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _illuminationController,
                  textInputAction: TextInputAction.next,
                ),
                const Flexible(
                    flex: 3,
                    child: ListMeasurementWidget()
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    StorageConditions _storageConditions = StorageConditions(idStorageConditions: UniqueKey().hashCode, name: _nameController.text, temperature: double.parse(_temperatureController.text), humidity: double.parse(_humidityController.text), illumination: double.parse(_illuminationController.text), measurementTemperature: getMeasurementTemperature(), measurementHumidity: getMeasurementHumidity(), measurementIllumination: getMeasurementIllumination());
                    _controller?.addStorageConditions(_storageConditions);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is StorageConditionsAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Добавлен")));}
                    if (state is StorageConditionsResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is StorageConditionsResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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