import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/nomenclature/PutNomenclaturePage.dart';
import '../../../controller/MeasurementController.dart';
import '../../../controller/ProductController.dart';
import '../../../model/Measurement.dart';
import '../../../model/Product.dart';

class PutListProductWidget extends StatefulWidget
{
  const PutListProductWidget({Key? key}) : super(key: key);

  @override
  _PutListProductWidgetState createState() => _PutListProductWidgetState();
}

class _PutListProductWidgetState extends StateMVC
{
  late ProductController _controller;
  late Product _product;

  _PutListProductWidgetState() : super(ProductController()) {_controller = controller as ProductController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is ProductResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProductResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _productList = (state as ProductGetListResultSuccess).productList;
      _product = _productList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Товар",),
          items: _productList.map((Product items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Product? item) {
            setState(() {
              _product = item!;
            });
            PutNomenclaturePage.of(context)?.setProduct(_product);
          }
      );
  }
  }

}