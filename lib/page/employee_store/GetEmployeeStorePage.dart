import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/employee_store/DeleteEmployeeStorePage.dart';
import 'package:retail/page/address/PutAddressPage.dart';
import '../../controller/EmployeeStoreController.dart';
import '../../model/EmployeeStore.dart';

class GetEmployeeStorePage extends StatefulWidget
{
  final int id;
  const GetEmployeeStorePage({Key? key, required this.id}) : super(key: key);

  @override
  GetEmployeeStorePageState createState() => GetEmployeeStorePageState(id);
}

class GetEmployeeStorePageState extends StateMVC
{
  EmployeeStoreController? _controller;
  final int _id;

  GetEmployeeStorePageState(this._id) : super(EmployeeStoreController()) {_controller = controller as EmployeeStoreController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getEmployeeStore(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutAddressPage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeleteEmployeeStorePage(_id)));
        if (value == true)
        {
          _controller?.deleteEmployeeStore(_id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Сотрудник склада удален")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is EmployeeStoreResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is EmployeeStoreResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _employeeStore = (state as EmployeeStoreGetItemResultSuccess).employeeStore;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о сотруднике склада №$_id"),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: _handleClick, // функция при нажатии
                itemBuilder: (BuildContext context)
                {
                  return {'Изменить', 'Удалить'}.map((String choice)
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
                  Text("Полное имя: ${_employeeStore.getSurname} ${_employeeStore.getName} ${_employeeStore.getPatronymic} \n"
                      "Адрес: ${_employeeStore.getAddress} \n"
                      "Средство связи: ${_employeeStore.getCommunication} \n"
                      "Организация: ${_employeeStore.getOrganization} \n"
                      "Должность: ${_employeeStore.getPosition} \n"
                      "Свободен: ${_employeeStore.getFree}"
                      , style: const TextStyle(fontSize: 22)),

                ],
              ),
            ),
          ),
      );
    }
  }
}