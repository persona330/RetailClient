import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/area/CreateAreaPage.dart';
import '../../controller/StorageConditionsController.dart';
import '../../model/StorageConditions.dart';

class ListStorageConditionsWidget extends StatefulWidget
{
  const ListStorageConditionsWidget({Key? key}) : super(key: key);

  @override
  _ListStorageConditionsWidgetState createState() => _ListStorageConditionsWidgetState();
}

class _ListStorageConditionsWidgetState extends StateMVC
{
  late StorageConditionsController _controller;
  late StorageConditions _storageConditions;

  _ListStorageConditionsWidgetState() : super(StorageConditionsController()) {_controller = controller as StorageConditionsController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getStorageConditionsList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is StorageConditionsResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StorageConditionsResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _storageConditionsList = (state as StorageConditionsGetListResultSuccess).storageConditionsList;
      _storageConditions = _storageConditionsList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Условия хранения",),
          items: _storageConditionsList.map((StorageConditions items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (StorageConditions? item) {
            setState(() {_storageConditions = item!;});
            CreateAreaPage.of(context)?.setStorageConditions(_storageConditions);
          }
      );
  }
  }

}