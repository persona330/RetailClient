import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/stillage/CreateStillagePage.dart';

import '../../../controller/AreaController.dart';
import '../../../model/Area.dart';

class CreateListAreaWidget extends StatefulWidget
{
  const CreateListAreaWidget({Key? key}) : super(key: key);

  @override
  _CreateListAreaWidgetState createState() => _CreateListAreaWidgetState();
}

class _CreateListAreaWidgetState extends StateMVC
{
  late AreaController _controller;
  late Area _area;

  _CreateListAreaWidgetState() : super(AreaController()) {_controller = controller as AreaController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getAreaList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is AreaResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is AreaResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _areaList = (state as AreaGetListResultSuccess).areaList;
      _area = _areaList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Зона",),
          items: _areaList.map((Area items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Area? item) {
            setState(() {
              _area = item!;
            });
            CreateStillagePage.of(context)?.setArea(_area);
          }
      );
  }
  }

}