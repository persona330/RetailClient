import 'package:flutter/material.dart';
import '../../../model/EmployeeStore.dart';

class ItemEmployeeStoreWidget extends StatelessWidget
{
  final EmployeeStore employeeStore;

  ItemEmployeeStoreWidget(this.employeeStore);

  @override
  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${employeeStore.getId}"),
          title: Text('${employeeStore.getSurname} ${employeeStore.getName} ${employeeStore.getPatronymic}'),
          subtitle: const Text('Описание\n'),
      ),
    );
  }
}