import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/import/CreateImportPage.dart';
import 'package:retail/page/organization/CreateOrganizationPage.dart';

import '../../controller/ConsignmentNoteController.dart';
import '../../model/ConsignmentNote.dart';

class ListConsignmentNoteWidget extends StatefulWidget
{
  const ListConsignmentNoteWidget({Key? key}) : super(key: key);

  @override
  _ListConsignmentNoteWidgetState createState() => _ListConsignmentNoteWidgetState();
}

class _ListConsignmentNoteWidgetState extends StateMVC
{
  late ConsignmentNoteController _controller;
  late ConsignmentNote _consignmentNote;

  _ListConsignmentNoteWidgetState() : super(ConsignmentNoteController()) {_controller = controller as ConsignmentNoteController;}

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
          decoration: InputDecoration(labelText: "Накладная",),
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
            CreateImportPage.of(context)?.setConsignmentNote(_consignmentNote);
          }
      );
  }
  }

}