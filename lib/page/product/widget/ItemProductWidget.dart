import 'package:flutter/material.dart';
import '../../../model/Area.dart';
import '../../../model/Product.dart';

class ItemProductWidget extends StatelessWidget
{
  final Product product;

  ItemProductWidget(this.product);

  @override
  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${product.getIdProduct}"),
          title: Text('${product.getMengeAufLager}'),
          subtitle: const Text('Описание \n'),
      ),
    );
  }
}