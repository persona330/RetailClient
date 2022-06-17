import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/product/PutProductPage.dart';
import '../../../controller/PriceController.dart';
import '../../../model/Price.dart';

class PutListPriceWidget extends StatefulWidget
{
  const PutListPriceWidget({Key? key}) : super(key: key);

  @override
  _PutListPriceWidgetState createState() => _PutListPriceWidgetState();
}

class _PutListPriceWidgetState extends StateMVC
{
  late PriceController _controller;
  late Price _price;

  _PutListPriceWidgetState() : super(PriceController()) {_controller = controller as PriceController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getPriceList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is PriceResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is PriceResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _priceList = (state as PriceGetListResultSuccess).priceList;
      _price = _priceList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Цена",),
          items: _priceList.map((Price items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Price? item) {
            setState(() {_price = item!;});
            PutProductPage.of(context)?.setPrice(_price);
          }
      );
  }
  }

}