import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/organization/CreateOrganizationPage.dart';

import '../../controller/CommunicationController.dart';
import '../../model/Communication.dart';

class ListCommunicationWidget extends StatefulWidget
{
  const ListCommunicationWidget({Key? key}) : super(key: key);

  @override
  _ListCommunicationWidgetState createState() => _ListCommunicationWidgetState();
}

class _ListCommunicationWidgetState extends StateMVC
{
  late CommunicationController _controller;
  late Communication _communication;

  _ListCommunicationWidgetState() : super(CommunicationController()) {_controller = controller as CommunicationController;}

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
          decoration: InputDecoration(labelText: "Средство связи",),
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
            print(_communication);
            CreateOrganizationPage.of(context)?.setCommunication(_communication);
          }
      );
  }
  }

}