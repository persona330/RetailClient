import 'package:flutter/material.dart';
import '../../../model/Shelf.dart';

class ItemShelfWidget extends StatelessWidget
{
  final Shelf shelf;

  ItemShelfWidget(this.shelf);

  @override
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
          subtitle: const Text('Описание'),
      ),
    );
  }
}