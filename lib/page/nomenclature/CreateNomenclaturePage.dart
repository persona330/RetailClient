import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Group.dart';
import 'package:retail/model/Measurement.dart';
import 'package:retail/model/Organization.dart';
import 'package:retail/model/StorageConditions.dart';
import 'package:retail/page/nomenclature/widget/CreateListStorageConditionsWidget.dart';
import 'package:retail/page/employee_store/widget/CreateListOrganizationWidget.dart';
import 'package:retail/page/group/widget/CreateListGroupWidget.dart';
import 'package:retail/page/nomenclature/widget/CreateListBoxWidget.dart';
import 'package:retail/page/nomenclature/widget/CreateListMeasurementWidget.dart';
import '../../controller/NomenclatureController.dart';
import '../../model/Box.dart';
import '../../model/Nomenclature.dart';

class CreateNomenclaturePage extends StatefulWidget
{
  const CreateNomenclaturePage({Key? key}) : super(key: key);

  @override
  _CreateNomenclaturePageState createState() => _CreateNomenclaturePageState();

  static _CreateNomenclaturePageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateNomenclaturePageState? result =
    context.findAncestorStateOfType<_CreateNomenclaturePageState>();
    return result;
  }
}

class _CreateNomenclaturePageState extends StateMVC
{
  NomenclatureController? _controller;

  _CreateNomenclaturePageState() : super(NomenclatureController()) {_controller = controller as NomenclatureController;}

  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _costController = TextEditingController();
  final _productionDateController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _weightController = TextEditingController();
  final _sizeController = TextEditingController();
  late String? _productionDate = "Введите дату";
  late String? _expirationDate = "Введите дату";
  late Measurement _measurement;
  late Organization _organization;
  late Group _group;
  late Box _box;
  late StorageConditions _storageConditions;

  Organization getOrganization(){return _organization;}
  void setOrganization(Organization organization){_organization = organization;}

  Measurement getMeasurement(){return _measurement;}
  void setMeasurement(Measurement measurement){_measurement = measurement;}

  Group getGroup(){return _group;}
  void setGroup(Group group){_group = group;}

  Box getBox(){return _box;}
  void setBox(Box box){_box = box;}

  StorageConditions getStorageConditions(){return _storageConditions;}
  void setStorageConditions(StorageConditions storageConditions){_storageConditions = storageConditions;}

  Future<void> _selectProductionDate(BuildContext context) async
  {
    final DateTime? _dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    );
    if (_dateTime != null) setState(() {_productionDate = DateFormat("dd-MM-yyyy").format(_dateTime);});
  }

  Future<void> _selectExpirationDate(BuildContext context) async
  {
    final DateTime? _dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    );
    if (_dateTime != null) setState(() {_expirationDate = DateFormat("dd-MM-yyyy").format(_dateTime);});
  }

  @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    _nameController.dispose();
    _brandController.dispose();
    _costController.dispose();
    _productionDateController.dispose();
    _expirationDateController.dispose();
    _weightController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text('Создание номенклатуры')),
      body: SingleChildScrollView(
          child:
          Container(
            height: MediaQuery.of(context).size.height,
            // this.left, this.top, this.right, this.bottom
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Название"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я]")),],
                  decoration: const InputDecoration(labelText: "Бренд"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _brandController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Вес"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _weightController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Объем"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _sizeController,
                  textInputAction: TextInputAction.next,
                ),
                Row(
                  children: [
                    Expanded(child:
                    TextFormField(
                      keyboardType: TextInputType.datetime,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[0-9\-:]")),],
                      decoration: const InputDecoration(labelText: "Дата прибытия"),
                      style: const TextStyle(fontSize: 14, color: Colors.blue),
                      controller: _productionDateController,
                      textInputAction: TextInputAction.next,
                    ),
                    ),
                    IconButton(
                        onPressed: ()
                        {
                          _selectProductionDate(context);
                          _productionDateController.text = _productionDate!;
                        },
                        icon: const Icon(Icons.calendar_today)
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child:
                    TextFormField(
                      keyboardType: TextInputType.datetime,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[0-9\-:]")),],
                      decoration: const InputDecoration(labelText: "Срок годности"),
                      style: const TextStyle(fontSize: 14, color: Colors.blue),
                      controller: _expirationDateController,
                      textInputAction: TextInputAction.next,
                    ),
                    ),
                    IconButton(
                        onPressed: ()
                        {
                          _selectExpirationDate(context);
                          _expirationDateController.text = _expirationDate!;
                        },
                        icon: const Icon(Icons.calendar_today)
                    ),
                  ],
                ),
                const Flexible(
                  flex: 1,
                  child: CreateListMeasurementWidget(),
                ),
                const Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: CreateListGroupWidget(),
                ),
                const Flexible(
                  flex: 3,
                  child: CreateListOrganizationWidget(),
                ),
                const Flexible(
                  flex: 4,
                  child: CreateListStorageConditionsWidget(),
                ),
                const Flexible(
                  flex: 5,
                  child: CreateListBoxWidget(),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Nomenclature _nomenclature = Nomenclature(idNomenclature: UniqueKey().hashCode, name: _nameController.text, brand: _brandController.text, cost: double.parse(_costController.text), productionDate: DateTime.parse(_productionDate!), expirationDate: DateTime.parse(_expirationDate!), weight: double.parse(_weightController.text), size: double.parse(_sizeController.text), group: getGroup(), organization: getOrganization(), measurement: getMeasurement(), box: getBox(), storageConditions: getStorageConditions());
                    print(_nomenclature);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is NomenclatureAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Номенклатура создана")));}
                    if (state is NomenclatureResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is NomenclatureResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Создать'),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
      ),
    );
  }
}