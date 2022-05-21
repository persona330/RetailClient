import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/VerticalSections.dart';

class ItemVerticalSectionsPage extends StatelessWidget
{
  final VerticalSections verticalSections;

  ItemVerticalSectionsPage(this.verticalSections);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${verticalSections.getIdVerticalSections}"),
          title: Text('${verticalSections.getNumber}'),
          subtitle: Text(
          'Тело: \n'
          ),
      ),
    );
  }
}