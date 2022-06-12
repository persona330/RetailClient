import 'package:flutter/material.dart';
import '../../../model/StorageConditions.dart';

class ItemStorageConditionsWidget extends StatelessWidget
{
  final StorageConditions storageConditions;

  ItemStorageConditionsWidget(this.storageConditions);

  @override
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
          subtitle: const Text('Описание'),
      ),
    );
  }
}