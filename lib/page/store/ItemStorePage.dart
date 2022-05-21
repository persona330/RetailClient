import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Store.dart';

class ItemStorePage extends StatelessWidget
{
  final Store store;

  ItemStorePage(this.store);

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
          subtitle: Text(
          'Описание \n'
          ),
          //trailing: Text('${address.getIdAddress}'),
      ),
    );
  }
}