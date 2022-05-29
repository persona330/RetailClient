import 'package:flutter/material.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/service/PostService.dart';

import '../../controller/CommunicationController.dart';
import '../../model/Communication.dart';
import 'CreateCommunicationPage.dart';
import 'GetCommunicationPage.dart';
import 'ItemCommunicationPage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllCommunicationPage extends StatefulWidget
{
  const GetAllCommunicationPage({Key? key}) : super(key: key);

  @override
  _GetAllCommunicationPageState createState() => _GetAllCommunicationPageState();
}

// Домашняя страница
class _GetAllCommunicationPageState extends StateMVC
{
  late CommunicationController _controller;

  _GetAllCommunicationPageState() : super(CommunicationController()) {_controller = controller as CommunicationController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getCommunicationList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Средства связи"),
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
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCommunicationPage())); },
        tooltip: 'Добавить средство связи',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is CommunicationResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CommunicationResultFailure)
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
      final _communicationList = (state as CommunicationGetListResultSuccess).communicationList;
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
                  itemCount: _communicationList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetCommunicationPage(id: _communicationList[index].getIdCommunication!)));
                      },
                      child: ItemCommunicationPage(_communicationList[index]),
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


