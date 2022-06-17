import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Measurement.dart';
import 'package:retail/page/area/widget/CreateListStorageConditionsWidget.dart';
import '../../controller/PriceController.dart';
import '../../model/Price.dart';

class CreatePricePage extends StatefulWidget
{
  const CreatePricePage({Key? key}) : super(key: key);

  @override
  _CreatePricePageState createState() => _CreatePricePageState();

  static _CreatePricePageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreatePricePageState? result =
    context.findAncestorStateOfType<_CreatePricePageState>();
    return result;
  }
}

class _CreatePricePageState extends StateMVC
{
  PriceController? _controller;

  _CreatePricePageState() : super(PriceController()) {_controller = controller as PriceController;}

  final _quantityController = TextEditingController();

  late Measurement _measurement;

  Measurement getMeasurement(){ return _measurement;}
  void setMeasurement(Measurement measurement){ _measurement = measurement;}

  @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text('Создание цены')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),],
                  decoration: const InputDecoration(labelText: "Количество"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _quantityController,
                  textInputAction: TextInputAction.next,
                ),
                const Flexible(
                  flex: 1,
                  child: CreateListStorageConditionsWidget(),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Price _price = Price(idPrice: UniqueKey().hashCode, quantity: int.parse(_quantityController.text), measurement: getMeasurement());
                    _controller?.addPrice(_price);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is PriceAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Цена создана")));}
                    if (state is PriceResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is PriceResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Создать'),
                ),
              ],
            ),
          ),
      ),
    );
  }
}