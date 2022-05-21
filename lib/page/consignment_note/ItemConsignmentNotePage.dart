import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/ConsignmentNote.dart';

class ItemConsignmentNotePage extends StatelessWidget
{
  final ConsignmentNote consignmentNote;

  ItemConsignmentNotePage(this.consignmentNote);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${consignmentNote.getIdConsignmentNote}"),
          title: Text('${consignmentNote.getNumber}'),
          subtitle: Text(
          'Тело: \n'
          ),
      ),
    );
  }
}