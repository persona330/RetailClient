import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Box.dart';

class ItemBoxPage extends StatelessWidget
{
  final Box box;

  ItemBoxPage(this.box);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${box.getIdBox}"),
          title: Text('${box.getNumber}'),
          subtitle: Text(
          'Тело: \n'
          ),
      ),
    );
  }
}