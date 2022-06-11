import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/employee_store/PutEmployeeStorePage.dart';
import '../../../controller/PositionController.dart';
import '../../../model/Position.dart';

class PutListPositionWidget extends StatefulWidget
{
  const PutListPositionWidget({Key? key}) : super(key: key);

  @override
  _PutListPositionWidgetState createState() => _PutListPositionWidgetState();
}

class _PutListPositionWidgetState extends StateMVC
{
  late PositionController _controller;
  late Position _position;

  _PutListPositionWidgetState() : super(PositionController()) {_controller = controller as PositionController;}

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
            PutEmployeeStorePage.of(context)?.setPosition(_position);
          }
      );
  }
  }

}