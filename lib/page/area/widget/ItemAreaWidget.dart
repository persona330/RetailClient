import 'package:flutter/material.dart';
import '../../../model/Area.dart';

class ItemAreaWidget extends StatelessWidget
{
  final Area area;

  ItemAreaWidget(this.area);

  @override
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
          subtitle: const Text('Описание \n'),
      ),
    );
  }
}