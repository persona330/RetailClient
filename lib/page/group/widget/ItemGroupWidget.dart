import 'package:flutter/material.dart';
import '../../../model/Group.dart';

class ItemGroupWidget extends StatelessWidget
{
  final Group group;

  ItemGroupWidget(this.group);

  @override
  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${group.getIdGroup}"),
          title: Text('${group.getName}'),
          subtitle: const Text('Описание \n'),
      ),
    );
  }
}