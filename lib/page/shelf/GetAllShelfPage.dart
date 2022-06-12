import 'package:flutter/material.dart';
import 'package:retail/page/address/GetAddressPage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/ShelfController.dart';
import '../../model/Shelf.dart';
import 'CreateShelfPage.dart';
import 'widget/ItemShelfWidget.dart';

class GetAllShelfPage extends StatefulWidget
{
  const GetAllShelfPage({Key? key}) : super(key: key);

  @override
  _GetAllShelfPageState createState() => _GetAllShelfPageState();
}

class _GetAllShelfPageState extends StateMVC
{
  late ShelfController _controller;

  _GetAllShelfPageState() : super(ShelfController()) {_controller = controller as ShelfController;}

  Widget appBarTitle = const Text("Полка");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  @override
  void initState()
  {
    super.initState();
    _controller.getShelfList();
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
                appBarTitle = const Text("Полка");
              }
            });
          } ,),]
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateShelfPage())); },
        tooltip: 'Добавить полку',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is ShelfResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ShelfResultFailure)
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
      final _shelfList = (state as ShelfGetListResultSuccess).shelfList;
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
                  itemCount: _shelfList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetAddressPage(id: _shelfList[index].getIdShelf!)));
                      },
                      child: ItemShelfWidget(_shelfList[index]),
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


