import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../controller/ShelfController.dart';
import '../../../model/Shelf.dart';
import '../PutBoxPage.dart';

class PutListShelfWidget extends StatefulWidget
{
  const PutListShelfWidget({Key? key}) : super(key: key);

  @override
  _PutListShelfWidgetState createState() => _PutListShelfWidgetState();
}

class _PutListShelfWidgetState extends StateMVC
{
  late ShelfController _controller;
  late Shelf _shelf;

  _PutListShelfWidgetState() : super(ShelfController()) {_controller = controller as ShelfController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getShelfList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is ShelfResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ShelfResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _shelfList = (state as ShelfGetListResultSuccess).shelfList;
      _shelf = _shelfList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Полка",),
          items: _shelfList.map((Shelf items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Shelf? item) {
            setState(() {
              _shelf = item!;
            });
            PutBoxPage.of(context)?.setShelf(_shelf);
          }
      );
  }
  }

}