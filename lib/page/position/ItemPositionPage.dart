import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Position.dart';

class ItemPositionPage extends StatelessWidget
{
  final Position position;

  ItemPositionPage(this.position);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${position.getIdPosition}"),
          title: Text('${position.getName}'),
          subtitle: Text(
          'Тело: \n'
          ),
      ),
    );
  }
}