import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Group.dart';

class ItemGroupPage extends StatelessWidget
{
  final Group group;

  ItemGroupPage(this.group);

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
          subtitle: Text(
          'Описание \n'
          ),
      ),
    );
  }
}