import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/StoreController.dart';
import '../../model/Store.dart';
import 'CreateStorePage.dart';
import 'GetStorePage.dart';
import 'widget/ItemStoreWidget.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllStorePage extends StatefulWidget
{
  const GetAllStorePage({Key? key}) : super(key: key);

  @override
  _GetAllStorePageState createState() => _GetAllStorePageState();
}

// Домашняя страница
class _GetAllStorePageState extends StateMVC
{
  late StoreController _controller;

  _GetAllStorePageState() : super(StoreController()) {_controller = controller as StoreController;}

  Widget appBarTitle = const Text("Склады");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  @override
  void initState()
  {
    super.initState();
    _controller.getStoreList();
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
                appBarTitle = const Text("Склады");
              }
            });
          } ,),]
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateStorePage())); },
        tooltip: 'Добавить склад',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is StoreResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StoreResultFailure)
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
      final storeList = (state as StoreGetListResultSuccess).storeList;
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
                  itemCount: storeList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetStorePage(id: storeList[index].getIdStore!)));
                      },
                      child: ItemStoreWidget(storeList[index]),
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


