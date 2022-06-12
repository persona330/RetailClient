import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/import/CreateImportPage.dart';

import '../../../controller/ConsignmentNoteController.dart';
import '../../../model/ConsignmentNote.dart';
import '../PutImportPage.dart';

class PutListConsignmentNoteWidget extends StatefulWidget
{
  const PutListConsignmentNoteWidget({Key? key}) : super(key: key);

  @override
  _PutListConsignmentNoteWidgetState createState() => _PutListConsignmentNoteWidgetState();
}

class _PutListConsignmentNoteWidgetState extends StateMVC
{
  late ConsignmentNoteController _controller;
  late ConsignmentNote _consignmentNote;

  _PutListConsignmentNoteWidgetState() : super(ConsignmentNoteController()) {_controller = controller as ConsignmentNoteController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getConsignmentNoteList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is ConsignmentNoteResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ConsignmentNoteResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _consignmentNoteList = (state as ConsignmentNoteGetListResultSuccess).consignmentNoteList;
      _consignmentNote = _consignmentNoteList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Накладная",),
          items: _consignmentNoteList.map((ConsignmentNote items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (ConsignmentNote? item) {
            setState(() {
              _consignmentNote = item!;
            });
            PutImportPage.of(context)?.setConsignmentNote(_consignmentNote);
          }
      );
  }
  }

}