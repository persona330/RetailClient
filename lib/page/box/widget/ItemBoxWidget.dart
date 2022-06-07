import 'package:flutter/material.dart';
import '../../../model/Box.dart';

class ItemBoxWidget extends StatelessWidget
{
  final Box box;

  ItemBoxWidget(this.box);

  @override
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
          subtitle: const Text('Описание \n'),
      ),
    );
  }
}