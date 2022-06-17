import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/area/widget/PutListStorageConditionsWidget.dart';
import '../../controller/AreaController.dart';
import '../../controller/PriceController.dart';
import '../../model/Measurement.dart';
import '../../model/Price.dart';

class PutPricePage extends StatefulWidget
{
  final int id;
  const PutPricePage({Key? key, required this.id}) : super(key: key);

  @override
  PutPricePageState createState() => PutPricePageState(id);

  static PutPricePageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutPricePageState? result =
    context.findAncestorStateOfType<PutPricePageState>();
    return result;
  }
}

class PutPricePageState extends StateMVC
{
  PriceController? _controller;
  final int _id;

  PutPricePageState(this._id) : super(AreaController()) {_controller = controller as PriceController;}

  final _quantityController = TextEditingController();
  late Measurement _measurement;

  Measurement getMeasurement(){ return _measurement;}
  void setMeasurement(Measurement measurement){ _measurement = measurement;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getPrice(_id);
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
    final state = _controller?.currentState;
    if (state is PriceResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is PriceResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _price = (state as PriceGetItemResultSuccess).price;
      _quantityController.text = _price.getQuantity!.toString();
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение цены')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
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
                    child: PutListStorageConditionsWidget(),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Price _price1 = Price(idPrice: _id, quantity: int.parse(_quantityController.text), measurement: getMeasurement());
                      _controller?.putPrice(_price1, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is PricePutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Цена изменена")));}
                      if (state is PriceResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is PriceResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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