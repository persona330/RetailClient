import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../controller/ProductController.dart';
import '../../../model/Product.dart';
import '../CreateNomenclaturePage.dart';

class CreateListProductWidget extends StatefulWidget
{
  const CreateListProductWidget({Key? key}) : super(key: key);

  @override
  _CreateListProductWidgetState createState() => _CreateListProductWidgetState();
}

class _CreateListProductWidgetState extends StateMVC
{
  late ProductController _controller;
  late Product _product;

  _CreateListProductWidgetState() : super(ProductController()) {_controller = controller as ProductController;}

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
            CreateNomenclaturePage.of(context)?.setProduct(_product);
          }
      );
  }
  }

}