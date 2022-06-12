import 'package:flutter/material.dart';
import '../../../model/Supplier.dart';

class ItemSupplierWidget extends StatelessWidget
{
  final Supplier supplier;

  ItemSupplierWidget(this.supplier);

  @override
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
          subtitle: const Text('Описание'),
      ),
    );
  }
}