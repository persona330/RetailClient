import 'package:flutter/material.dart';
import '../../../model/Position.dart';

class ItemPositionWidget extends StatelessWidget
{
  final Position position;

  ItemPositionWidget(this.position);

  @override
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
          subtitle: const Text('Описание'),
      ),
    );
  }
}