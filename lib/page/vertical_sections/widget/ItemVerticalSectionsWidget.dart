import 'package:flutter/material.dart';
import '../../../model/VerticalSections.dart';

class ItemVerticalSectionsWidget extends StatelessWidget
{
  final VerticalSections verticalSections;

  ItemVerticalSectionsWidget(this.verticalSections);

  @override
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
          subtitle: const Text('Описание'),
      ),
    );
  }
}