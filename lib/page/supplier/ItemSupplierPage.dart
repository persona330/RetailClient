import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Supplier.dart';

class ItemSupplierPage extends StatelessWidget
{
  final Supplier supplier;

  ItemSupplierPage(this.supplier);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${supplier.getIdSupplier}"),
          title: Text('${supplier.getName}'),
          subtitle: Text(
          'Тело: \n'
          ),
      ),
    );
  }
}