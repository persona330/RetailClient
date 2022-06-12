import 'package:flutter/material.dart';
import '../../../model/Stillage.dart';

class ItemStillageWidget extends StatelessWidget
{
  final Stillage stillage;

  ItemStillageWidget(this.stillage);

  @override
  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${stillage.getIdStillage}"),
          title: Text('${stillage.getNumber}'),
          subtitle: const Text('Описание'),
      ),
    );
  }
}