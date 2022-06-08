import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../controller/CommunicationController.dart';
import '../../../model/Communication.dart';

class PutListCommunicationWidget extends StatefulWidget
{
  const PutListCommunicationWidget({Key? key}) : super(key: key);

  @override
  _PutListCommunicationWidgetState createState() => _PutListCommunicationWidgetState();
}

class _PutListCommunicationWidgetState extends StateMVC
{
  late CommunicationController _controller;
  late Communication _communication;

  _PutListCommunicationWidgetState() : super(CommunicationController()) {_controller = controller as CommunicationController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getCommunicationList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is CommunicationResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CommunicationResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final communicationList = (state as CommunicationGetListResultSuccess).communicationList;
      _communication = communicationList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Средство связи",),
          items: communicationList.map((Communication items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Communication? item) {
            setState(() {
              _communication = item!;
            });
            //PutOrganizationPage.of(context)?.setCommunication(_communication);
          }
      );
  }
  }

}