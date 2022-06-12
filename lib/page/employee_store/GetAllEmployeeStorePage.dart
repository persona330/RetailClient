import 'package:flutter/material.dart';
import 'package:retail/page/employee_store/GetEmployeeStorePage.dart';
import 'package:retail/page/employee_store/widget/ItemEmployeeStoreWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/EmployeeStoreController.dart';
import '../../model/EmployeeStore.dart';
import 'CreateEmployeeStorePage.dart';

class GetAllEmployeeStorePage extends StatefulWidget
{
  const GetAllEmployeeStorePage({Key? key}) : super(key: key);

  @override
  _GetAllEmployeeStorePageState createState() => _GetAllEmployeeStorePageState();
}

class _GetAllEmployeeStorePageState extends StateMVC
{
  late EmployeeStoreController _controller;

  _GetAllEmployeeStorePageState() : super(EmployeeStoreController()) {_controller = controller as EmployeeStoreController;}

  Widget appBarTitle = const Text("Сотрудник");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  @override
  void initState()
  {
    super.initState();
    _controller.getEmployeeStoreList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
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
                appBarTitle = const Text("Сотрудник");
              }
            });
          } ,),]
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateEmployeeStorePage())); },
        tooltip: 'Добавить сотрудника',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
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
      // отображаем список постов
      final _employeeStoreList = (state as EmployeeStoreGetListResultSuccess).employeeStoreList;
      return Column(
        children: [
          Expanded(
            child:
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                // ListView.builder создает элемент списка
                // только когда он видим на экране
                child: ListView.builder(
                  itemCount: _employeeStoreList.length,
                  itemBuilder: (context, index)
                  {
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetEmployeeStorePage(id: _employeeStoreList[index].getId!)));
                      },
                      child: ItemEmployeeStoreWidget(_employeeStoreList[index]),
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


