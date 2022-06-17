import 'package:flutter/material.dart';
import '../../../model/Price.dart';

class ItemPriceWidget extends StatelessWidget
{
  final Price price;

  ItemPriceWidget(this.price);

  @override
  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${price.getIdPrice}"),
          title: Text('${price.getQuantity}'),
          subtitle: const Text('Описание \n'),
      ),
    );
  }
}