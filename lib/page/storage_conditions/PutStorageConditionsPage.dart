import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/storage_conditions/widget/PutListMeasurementHumidityWidget.dart';
import 'package:retail/page/storage_conditions/widget/PutListMeasurementIlluminationWidget.dart';
import 'package:retail/page/storage_conditions/widget/PutListMeasurementTemperatureWidget.dart';
import '../../controller/StorageConditionsController.dart';
import '../../model/Measurement.dart';
import '../../model/StorageConditions.dart';

class PutStorageConditionsPage extends StatefulWidget
{
  final int id;
  const PutStorageConditionsPage({Key? key, required this.id}) : super(key: key);

  @override
  PutStorageConditionsPageState createState() => PutStorageConditionsPageState(id);

  static PutStorageConditionsPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutStorageConditionsPageState? result =
    context.findAncestorStateOfType<PutStorageConditionsPageState>();
    return result;
  }
}

class PutStorageConditionsPageState extends StateMVC
{
  StorageConditionsController? _controller;
  final int _id;

  PutStorageConditionsPageState(this._id) : super(StorageConditionsController()) {_controller = controller as StorageConditionsController;}

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
    _controller?.getStorageConditions(_id);
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
    final state = _controller?.currentState;
    if (state is StorageConditionsResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StorageConditionsResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _storageConditions = (state as StorageConditionsGetItemResultSuccess).storageConditions;
      _nameController.text = _storageConditions.getName!;
      _temperatureController.text = _storageConditions.getTemperature!.toString();
      _humidityController.text = _storageConditions.getHumidity!.toString();
      _illuminationController.text = _storageConditions.getIllumination!.toString();
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение условий хранения')),
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
                    decoration: const InputDecoration(labelText: "Температура"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _temperatureController,
                    textInputAction: TextInputAction.next,
                  ),
                  const Flexible(
                    flex: 1,
                    child: PutListMeasurementTemperatureWidget(),
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
                      child: PutListMeasurementHumidityWidget()
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
                      child: PutListMeasurementIlluminationWidget()
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      StorageConditions _storageConditions = StorageConditions(idStorageConditions: _id, name: _nameController.text, temperature: double.parse(_temperatureController.text), humidity: double.parse(_humidityController.text), illumination: double.parse(_illuminationController.text), measurementTemperature: getMeasurementTemperature(), measurementHumidity: getMeasurementHumidity(), measurementIllumination: getMeasurementIllumination());
                      _controller?.addStorageConditions(_storageConditions);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is StorageConditionsPutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Условия хранения изменены")));}
                      if (state is StorageConditionsResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is StorageConditionsResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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