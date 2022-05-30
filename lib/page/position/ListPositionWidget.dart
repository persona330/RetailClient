import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/organization/CreateOrganizationPage.dart';
import 'package:retail/page/supplier/CreateSupplierPage.dart';

import '../../controller/PositionController.dart';
import '../../model/Position.dart';

class ListPositionWidget extends StatefulWidget
{
  const ListPositionWidget({Key? key}) : super(key: key);

  @override
  _ListPositionWidgetState createState() => _ListPositionWidgetState();
}

class _ListPositionWidgetState extends StateMVC
{
  late PositionController _controller;
  late Position _position;

  _ListPositionWidgetState() : super(AddressController()) {_controller = controller as PositionController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getPositionList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is PositionResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is PositionResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _positionList = (state as PositionGetListResultSuccess).positionList;
      _position = _positionList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Должность",),
          items: _positionList.map((Position items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Position? item) {
            setState(() {
              _position = item!;
            });
            CreateSupplierPage.of(context)?.setPosition(_position);
          }
      );
  }
  }

}