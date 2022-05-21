import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Stillage.dart';

class ItemStillagePage extends StatelessWidget
{
  final Stillage stillage;

  ItemStillagePage(this.stillage);

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
          subtitle: Text(
          'Тело: \n'
          ),
      ),
    );
  }
}