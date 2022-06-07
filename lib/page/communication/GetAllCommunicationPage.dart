import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/CommunicationController.dart';
import '../../model/Communication.dart';
import 'CreateCommunicationPage.dart';
import 'GetCommunicationPage.dart';
import 'widget/ItemCommunicationWidget.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllCommunicationPage extends StatefulWidget
{
  const GetAllCommunicationPage({Key? key}) : super(key: key);

  @override
  _GetAllCommunicationPageState createState() => _GetAllCommunicationPageState();
}

class _GetAllCommunicationPageState extends StateMVC
{
  late CommunicationController _controller;

  _GetAllCommunicationPageState() : super(CommunicationController()) {_controller = controller as CommunicationController;}

  Widget appBarTitle = const Text("Средства связи");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

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
                appBarTitle = const Text("Средства связи");
              }
            });
          } ,),]
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateCommunicationPage())); },
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
                padding: const EdgeInsets.all(10),
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
                      child: ItemCommunicationWidget(_communicationList[index]),
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


