import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Shelf.dart';

class ItemShelfPage extends StatelessWidget
{
  final Shelf shelf;

  ItemShelfPage(this.shelf);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${shelf.getIdShelf}"),
          title: Text('${shelf.getNumber}'),
          subtitle: Text(
          'Тело: \n'
          ),
      ),
    );
  }
}