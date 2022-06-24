import 'package:flutter/material.dart';
import 'package:retail/page/employee/widget/ItemEmployeeWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/employee_store/GetAllEmployeeStorePage.dart';
import 'package:retail/page/supplier/GetAllSupplierPage.dart';
import '../../controller/EmployeeController.dart';
import '../../model/Employee.dart';
import 'GetEmployeePage.dart';

class GetAllEmployeePage extends StatefulWidget
{
  const GetAllEmployeePage({Key? key}) : super(key: key);

  @override
  _GetAllEmployeePageState createState() => _GetAllEmployeePageState();
}

class _GetAllEmployeePageState extends StateMVC
{
  late EmployeeController _controller;

  _GetAllEmployeePageState() : super(EmployeeController()) {_controller = controller as EmployeeController;}

  Widget appBarTitle = const Text("Сотрудники");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  @override
  void initState()
  {
    super.initState();
    _controller.getEmployeeList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        leading: IconButton(icon:const Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(icon: actionIcon,onPressed:()
          {
            setState(() {
              if ( actionIcon.icon == Icons.search)
              {
                actionIcon = const Icon(Icons.close);
                appBarTitle = const TextField(
                  style: TextStyle(color: Colors.white,),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Поиск...",
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                );}
              else {
                actionIcon = const Icon(Icons.search);
                appBarTitle = const Text("Сотрудники");
              }
            });
          } ,),]
      ),
      // body - задает основное содержимое
      body: _buildContent(),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
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
      final _employeeList = (state as EmployeeGetListResultSuccess).employeeList;
      return Column(
        children: [
          Row(
            children: [
              Expanded(child:
              OutlinedButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GetAllEmployeeStorePage()));
                },
                child: const Text('Сотрудники склада'),
              ),
              ),
              Expanded(child:
              OutlinedButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GetAllSupplierPage()));
                },
                child: const Text('Поставщики'),
              ),
              ),
            ],
          ),
          Expanded(
            child:
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                // ListView.builder создает элемент списка
                // только когда он видим на экране
                child: ListView.builder(
                  itemCount: _employeeList.length,
                  itemBuilder: (context, index)
                  {
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetEmployeePage(id: _employeeList[index].getId!)));
                      },
                      child: ItemEmployeeWidget(_employeeList[index]),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
  }
  }
}


