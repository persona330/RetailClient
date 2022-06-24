import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/EmployeeController.dart';
import '../../model/Employee.dart';
import 'DeleteEmployeePage.dart';

class GetEmployeePage extends StatefulWidget
{
  final int id;
  const GetEmployeePage({Key? key, required this.id}) : super(key: key);

  @override
  GetEmployeePageState createState() => GetEmployeePageState(id);
}

class GetEmployeePageState extends StateMVC
{
  EmployeeController? _controller;
  final int _id;

  GetEmployeePageState(this._id) : super(EmployeeController()) {_controller = controller as EmployeeController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getEmployee(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeleteEmployeePage(_id)));
        if (value == true)
        {
          _controller?.deleteEmployee(_id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Сотрудник удален")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is EmployeeResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is EmployeeResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _employee = (state as EmployeeGetItemResultSuccess).employee;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о сотруднике №$_id"),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: _handleClick, // функция при нажатии
                itemBuilder: (BuildContext context)
                {
                  return {'Удалить'}.map((String choice)
                  {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: Scrollbar(
            child: Container(
              // this.left, this.top, this.right, this.bottom
              padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
              child: Column (
                children: [
                  Text("Полное имя: ${_employee.getSurname} ${_employee.getName} ${_employee.getPatronymic} \n"
                      "Адрес: ${_employee.getAddress} \n"
                      "Средство связи: ${_employee.getCommunication} \n"
                      "Организация: ${_employee.getOrganization} \n"
                      "Свободен: ${_employee.getFree}"
                      , style: const TextStyle(fontSize: 22)),

                ],
              ),
            ),
          ),
      );
    }
  }
}