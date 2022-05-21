import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/NomenclatureController.dart';
import '../../model/Nomenclature.dart';

class CreateNomenclaturePage extends StatefulWidget
{
  CreateNomenclaturePage({Key? key}) : super(key: key);

  @override
  _CreateNomenclaturePageState createState() => _CreateNomenclaturePageState();
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
  List<String> _groupList = [];
  List<String> _producerList = [];
  List<String> _measurementList = [];
  List<String> _boxList = [];
  List<String> _storageConditionsList = [];
  late String _group = _groupList[0];
  late String _producer = _producerList[0];
  late String _measurement = _measurementList[0];
  late String _box = _boxList[0];
  late String _storageConditions = _storageConditionsList[0];
  late String? _productionDate = "Введите дату";
  late String? _expirationDate = "Введите дату";

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
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Название"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я]")),],
                  decoration: const InputDecoration(labelText: "Бренд"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _brandController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Вес"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _weightController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Объем"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
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
                      style: TextStyle(fontSize: 14, color: Colors.blue),
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
                        icon: Icon(Icons.calendar_today)
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
                      style: TextStyle(fontSize: 14, color: Colors.blue),
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
                        icon: Icon(Icons.calendar_today)
                    ),
                  ],
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Группа товара",),
                    items: _groupList.map((String items){
                      return DropdownMenuItem(
                        child: Text(items.toString()),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item) { setState(() {_group = item!;});}
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Производитель",),
                    items: _producerList.map((String items){
                      return DropdownMenuItem(
                        child: Text(items.toString()),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item) { setState(() {_producer = item!;}); }
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Единица измерения",),
                    items: _measurementList.map((String items){
                      return DropdownMenuItem(
                        child: Text(items.toString()),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item) { setState(() {_measurement = item!;}); }
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Ячейка",),
                    items: _boxList.map((String items){
                      return DropdownMenuItem(
                        child: Text(items.toString()),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item) { setState(() {_box = item!;}); }
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Условия хранения",),
                    items: _storageConditionsList.map((String items){
                      return DropdownMenuItem(
                        child: Text(items.toString()),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item) { setState(() {_storageConditions = item!;}); }
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    //Address _address = Address(idAddress: 1, apartment:_apartmentController.text, entrance: int.parse(_entranceController.text), house: _houseController.text, street: _streetController.text, region: _regionController.text, city: _cityController.text, nation: _nationController.text);
                    //_controller?.addAddress(_address);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is NomenclatureAddResultSuccess)
                    {
                      print("Все ок");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Добавлен")));
                    }
                    if (state is NomenclatureResultLoading)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Загрузка")));
                    }
                    if (state is NomenclatureResultFailure) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Отправить'),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
      ),
    );
  }
}