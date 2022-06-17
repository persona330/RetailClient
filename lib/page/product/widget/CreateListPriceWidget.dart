import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../controller/PriceController.dart';
import '../../../model/Price.dart';
import '../CreateProductPage.dart';

class CreateListPriceWidget extends StatefulWidget
{
  const CreateListPriceWidget({Key? key}) : super(key: key);

  @override
  _CreateListPriceWidgetState createState() => _CreateListPriceWidgetState();
}

class _CreateListPriceWidgetState extends StateMVC
{
  late PriceController _controller;
  late Price _price;

  _CreateListPriceWidgetState() : super(PriceController()) {_controller = controller as PriceController;}

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
            CreateProductPage.of(context)?.setPrice(_price);
          }
      );
  }
  }

}