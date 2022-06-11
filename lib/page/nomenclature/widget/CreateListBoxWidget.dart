import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../controller/BoxController.dart';
import '../../../model/Box.dart';
import '../CreateNomenclaturePage.dart';

class CreateListBoxWidget extends StatefulWidget
{
  const CreateListBoxWidget({Key? key}) : super(key: key);

  @override
  _CreateListBoxWidgetState createState() => _CreateListBoxWidgetState();
}

class _CreateListBoxWidgetState extends StateMVC
{
  late BoxController _controller;
  late Box _box;

  _CreateListBoxWidgetState() : super(BoxController()) {_controller = controller as BoxController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getBoxList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is BoxResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is BoxResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _boxList = (state as BoxGetListResultSuccess).boxList;
      _box = _boxList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Ячейка",),
          items: _boxList.map((Box items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Box? item) {
            setState(() {
              _box = item!;
            });
            CreateNomenclaturePage.of(context)?.setBox(_box);
          }
      );
  }
  }

}