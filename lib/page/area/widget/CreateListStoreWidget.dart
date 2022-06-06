import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Store.dart';
import '../../../controller/StoreController.dart';
import '../CreateAreaPage.dart';

class CreateListStoreWidget extends StatefulWidget
{
  const CreateListStoreWidget({Key? key}) : super(key: key);

  @override
  _CreateListStoreWidgetState createState() => _CreateListStoreWidgetState();
}

class _CreateListStoreWidgetState extends StateMVC
{
  late StoreController _controller;
  late Store _store;

  _CreateListStoreWidgetState() : super(StoreController()) {_controller = controller as StoreController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getStoreList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is StoreResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StoreResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _storeList = (state as StoreGetListResultSuccess).storeList;
      _store = _storeList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Склад",),
          items: _storeList.map((Store items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Store? item) {
            setState(() {_store = item!;});
            CreateAreaPage.of(context)?.setStore(_store);
          }
      );
  }
  }

}