import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../controller/EmployeeStoreController.dart';
import '../../../model/EmployeeStore.dart';
import '../PutConsignmentNotePage.dart';

class PutListEmployeeStoreWidget extends StatefulWidget
{
  const PutListEmployeeStoreWidget({Key? key}) : super(key: key);

  @override
  _PutListEmployeeStoreWidgetState createState() => _PutListEmployeeStoreWidgetState();
}

class _PutListEmployeeStoreWidgetState extends StateMVC
{
  late EmployeeStoreController _controller;
  late EmployeeStore _employeeStore;

  _PutListEmployeeStoreWidgetState() : super(EmployeeStoreController()) {_controller = controller as EmployeeStoreController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getEmployeeStoreList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is EmployeeStoreResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is EmployeeStoreResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _employeeStoreList = (state as EmployeeStoreGetListResultSuccess).employeeStoreList;
      _employeeStore = _employeeStoreList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Сотрудник склада",),
          items: _employeeStoreList.map((EmployeeStore items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (EmployeeStore? item) {
            setState(() {_employeeStore = item!;});
            PutConsignmentNotePage.of(context)?.setEmployeeStore(_employeeStore);
          }
      );
  }
  }

}