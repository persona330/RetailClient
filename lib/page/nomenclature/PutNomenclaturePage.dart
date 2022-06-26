import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/nomenclature/widget/PutListBoxWidget.dart';
import 'package:retail/page/nomenclature/widget/PutListMeasurementWidget.dart';
import 'package:retail/page/nomenclature/widget/PutListProductWidget.dart';
import '../../controller/NomenclatureController.dart';
import '../../model/Box.dart';
import '../../model/Group.dart';
import '../../model/Measurement.dart';
import '../../model/Nomenclature.dart';
import '../../model/Organization.dart';
import '../../model/Product.dart';
import '../../model/StorageConditions.dart';
import '../nomenclature/widget/PutListStorageConditionsWidget.dart';
import '../nomenclature/widget/PutListOrganizationWidget.dart';
import '../nomenclature/widget/PutListGroupWidget.dart';

class PutNomenclaturePage extends StatefulWidget
{
  final int id;
  const PutNomenclaturePage({Key? key, required this.id}) : super(key: key);

  @override
  PutNomenclaturePageState createState() => PutNomenclaturePageState(id);

  static PutNomenclaturePageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutNomenclaturePageState? result =
    context.findAncestorStateOfType<PutNomenclaturePageState>();
    return result;
  }
}

class PutNomenclaturePageState extends StateMVC
{
  NomenclatureController? _controller;
  final int _id;

  PutNomenclaturePageState(this._id) : super(NomenclatureController()) {_controller = controller as NomenclatureController;}

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
  late Product _product;

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

  Product getProduct(){return _product;}
  void setProduct(Product product){_product = product;}

  Future<void> _selectProductionDate(BuildContext context) async
  {
    final DateTime? _dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    );
    if (_dateTime != null) setState(() {_productionDate = DateFormat("yyyy-MM-dd").format(_dateTime);});
  }

  Future<void> _selectExpirationDate(BuildContext context) async
  {
    final DateTime? _dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    );
    if (_dateTime != null) setState(() {_expirationDate = DateFormat("yyyy-MM-dd").format(_dateTime);});
  }

  @override
  void initState()
  {
    super.initState();
    _controller?.getNomenclature(_id);
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
    final state = _controller?.currentState;
    if (state is NomenclatureResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is NomenclatureResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _nomenclature = (state as NomenclatureGetItemResultSuccess).nomenclature;
      _nameController.text = _nomenclature.getName!;
      _brandController.text = _nomenclature.getBrand!;
      _costController.text = _nomenclature.getCost!.toString();
      _productionDateController.text = _nomenclature.getProductionDate!.toString();
      _expirationDateController.text = _nomenclature.getExpirationDate!.toString();
      _weightController.text = _nomenclature.getWeight!.toString();
      _sizeController.text = _nomenclature.getSize!.toString();
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение номенклатуры')),
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
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9\s]")),],
                  decoration: const InputDecoration(labelText: "Название"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я\s]")),],
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
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Цена"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _costController,
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
                  flex: 3,
                  child: PutListMeasurementWidget(),
                ),
                const Flexible(
                  flex: 3,
                  child: PutListGroupWidget(),
                ),
                const Flexible(
                  flex: 3,
                  child: PutListOrganizationWidget(),
                ),
                const Flexible(
                  flex: 3,
                  child: PutListStorageConditionsWidget(),
                ),
                const Flexible(
                  flex: 3,
                  child: PutListBoxWidget(),
                ),
                const Flexible(
                  flex: 3,
                  child: PutListProductWidget(),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Nomenclature _nomenclature1 = Nomenclature(idNomenclature: _id, name: _nameController.text, brand: _brandController.text, cost: double.parse(_costController.text), productionDate: DateTime.parse(_productionDate!), expirationDate: DateTime.parse(_expirationDate!), weight: double.parse(_weightController.text), size: double.parse(_sizeController.text), group: getGroup(), organization: getOrganization(), measurement: getMeasurement(), box: getBox(), storageConditions: getStorageConditions(), product: getProduct());
                    _controller?.putNomenclature(_nomenclature1, _id);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is NomenclaturePutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Номенклатура изменена")));}
                    if (state is NomenclatureResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is NomenclatureResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Изменить'),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      );
    }
  }

}