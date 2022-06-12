import 'package:flutter/material.dart';
import '../../../model/Store.dart';

class ItemStoreWidget extends StatelessWidget
{
  final Store store;

  ItemStoreWidget(this.store);

  @override
  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${store.getIdStore}"),
          title: Text('${store.getName}'),
          subtitle: const Text('Описание'),
          //trailing: Text('${address.getIdAddress}'),
      ),
    );
  }
}