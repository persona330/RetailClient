import 'package:flutter/material.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/AreaController.dart';
import '../../model/Area.dart';
import 'CreateAreaPage.dart';
import 'GetAreaPage.dart';
import 'widget/ItemAreaWidget.dart';

class GetAllAreaPage extends StatefulWidget
{
  const GetAllAreaPage({Key? key}) : super(key: key);

  @override
  _GetAllAreaPageState createState() => _GetAllAreaPageState();
}

// Домашняя страница
class _GetAllAreaPageState extends StateMVC
{
  late AreaController _controller;

  _GetAllAreaPageState() : super(AddressController()) {_controller = controller as AreaController;}

  Widget appBarTitle = const Text("Зоны");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  @override
  void initState()
  {
    super.initState();
    _controller.getAreaList();
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
                appBarTitle = const Text("Зоны");
              }
            });
          } ,),]
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAreaPage())); },
        tooltip: 'Добавить зону',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is AreaResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is AreaResultFailure)
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
      final areaList = (state as AreaGetListResultSuccess).areaList;
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
                  itemCount: areaList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetAreaPage(id: areaList[index].getIdArea!)));
                      },
                      child: ItemAreaWidget(areaList[index]),
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


