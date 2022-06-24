import 'package:flutter/material.dart';
import '../../../model/Employee.dart';

class ItemEmployeeWidget extends StatelessWidget
{
  final Employee employee;

  ItemEmployeeWidget(this.employee);

  @override
  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${employee.getId}"),
          title: Text('${employee.getSurname} ${employee.getName} ${employee.getPatronymic}'),
          subtitle: const Text('Описание\n'),
      ),
    );
  }
}