import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/storage_conditions/CreateStorageConditionsPage.dart';
import '../../controller/StorageConditionsController.dart';
import '../../model/StorageConditions.dart';
import 'GetStorageConditionsPage.dart';
import 'widget/ItemStorageConditionsWidget.dart';

class GetAllStorageConditionsPage extends StatefulWidget
{
  const GetAllStorageConditionsPage({Key? key}) : super(key: key);

  @override
  _GetAllStorageConditionsPageState createState() => _GetAllStorageConditionsPageState();
}

class _GetAllStorageConditionsPageState extends StateMVC
{
  late StorageConditionsController _controller;

  _GetAllStorageConditionsPageState() : super(StorageConditionsController()) {_controller = controller as StorageConditionsController;}

  Widget appBarTitle = const Text("Условия хранения");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  @override
  void initState()
  {
    super.initState();
    _controller.getStorageConditionsList();
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
                appBarTitle = const Text("Условия хранения");
              }
            });
          } ,),]
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateStorageConditionsPage())); },
        tooltip: 'Добавить условия хранения',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is StorageConditionsResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StorageConditionsResultFailure)
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
      final _storageConditionsList = (state as StorageConditionsGetListResultSuccess).storageConditionsList;
      return Column(
        children: [
          Expanded(
            child:
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: _storageConditionsList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetStorageConditionsPage(id: _storageConditionsList[index].getIdStorageConditions!)));
                      },
                      child: ItemStorageConditionsWidget(_storageConditionsList[index]),
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


