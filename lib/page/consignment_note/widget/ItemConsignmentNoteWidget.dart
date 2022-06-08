import 'package:flutter/material.dart';
import '../../../model/ConsignmentNote.dart';

class ItemConsignmentNoteWidget extends StatelessWidget
{
  final ConsignmentNote consignmentNote;

  ItemConsignmentNoteWidget(this.consignmentNote);

  @override
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
          subtitle: const Text('Описание \n'),
      ),
    );
  }
}