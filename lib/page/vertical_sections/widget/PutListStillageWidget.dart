import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/StillageController.dart';
import 'package:retail/model/Stillage.dart';
import '../PutVerticalSectionsPage.dart';

class PutListStillageWidget extends StatefulWidget
{
  const PutListStillageWidget({Key? key}) : super(key: key);

  @override
  _PutListStillageWidgetState createState() => _PutListStillageWidgetState();
}

class _PutListStillageWidgetState extends StateMVC
{
  late StillageController _controller;
  late Stillage _stillage;

  _PutListStillageWidgetState() : super(StillageController()) {_controller = controller as StillageController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getStillageList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is StillageResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StillageResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _stillageList = (state as StillageGetListResultSuccess).stillageList;
      _stillage = _stillageList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Стеллаж",),
          items: _stillageList.map((Stillage items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Stillage? item) {
            setState(() {
              _stillage = item!;
            });
            PutVerticalSectionsPage.of(context)?.setStillage(_stillage);
          }
      );
  }
  }

}