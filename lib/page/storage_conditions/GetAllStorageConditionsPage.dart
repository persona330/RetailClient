import 'package:flutter/material.dart';
import 'package:retail/page/address/CreateAddressPage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/StorageConditionsController.dart';
import '../../model/StorageConditions.dart';
import 'GetStorageConditionsPage.dart';
import 'ItemStorageConditionsPage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllStorageConditionsPage extends StatefulWidget
{
  const GetAllStorageConditionsPage({Key? key}) : super(key: key);

  @override
  _GetAllStorageConditionsPageState createState() => _GetAllStorageConditionsPageState();
}

// Домашняя страница
class _GetAllStorageConditionsPageState extends StateMVC
{
  late StorageConditionsController _controller;

  _GetAllStorageConditionsPageState() : super(StorageConditionsController()) {_controller = controller as StorageConditionsController;}

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
        title: Text("Условия хранения"),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
                onPressed: () => {
                  print("Click on settings button")
                }
                ),
        ],
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAddressPage())); },
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
                padding: EdgeInsets.all(10),
                // ListView.builder создает элемент списка
                // только когда он видим на экране
                child: ListView.builder(
                  itemCount: _storageConditionsList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetStorageConditionsPage(id: _storageConditionsList[index].getIdStorageConditions!)));
                      },
                      child: ItemStorageConditionsPage(_storageConditionsList[index]),
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


