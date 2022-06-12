import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../controller/SupplierController.dart';
import '../../../model/Supplier.dart';
import '../PutConsignmentNotePage.dart';

class PutListSupplierWidget extends StatefulWidget
{
  const PutListSupplierWidget({Key? key}) : super(key: key);

  @override
  _PutListSupplierWidgetState createState() => _PutListSupplierWidgetState();
}

class _PutListSupplierWidgetState extends StateMVC
{
  late SupplierController _controller;
  late Supplier _supplier;

  _PutListSupplierWidgetState() : super(SupplierController()) {_controller = controller as SupplierController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getSupplierList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is SupplierResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is SupplierResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _supplierList = (state as SupplierGetListResultSuccess).supplierList;
      _supplier = _supplierList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Поставщик",),
          items: _supplierList.map((Supplier items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Supplier? item) {
            setState(() {
              _supplier = item!;
            });
            PutConsignmentNotePage.of(context)?.setSupplier(_supplier);
          }
      );
  }
  }

}