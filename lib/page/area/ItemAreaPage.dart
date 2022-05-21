import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Area.dart';

class ItemAreaPage extends StatelessWidget
{
  final Area area;

  ItemAreaPage(this.area);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${area.getIdArea}"),
          title: Text('${area.getName}'),
          subtitle: Text(
          'Тело: \n'
          ),
          trailing: Text('${area.getIdArea}'),
      ),
    );
  }
}