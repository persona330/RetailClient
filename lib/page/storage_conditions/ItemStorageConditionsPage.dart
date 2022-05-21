import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/StorageConditions.dart';

class ItemStorageConditionsPage extends StatelessWidget
{
  final StorageConditions storageConditions;

  ItemStorageConditionsPage(this.storageConditions);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${storageConditions.getIdStorageConditions}"),
          title: Text('${storageConditions.getName}'),
          subtitle: Text(
          'Тело: \n'
          ),
      ),
    );
  }
}