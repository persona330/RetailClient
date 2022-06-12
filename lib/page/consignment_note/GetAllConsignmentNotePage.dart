import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/ConsignmentNoteController.dart';
import '../../model/ConsignmentNote.dart';
import 'CreateConsignmentNotePage.dart';
import 'GetConsignmentNotePage.dart';
import 'widget/ItemConsignmentNoteWidget.dart';

class GetAllConsignmentNotePage extends StatefulWidget
{
  const GetAllConsignmentNotePage({Key? key}) : super(key: key);

  @override
  _GetAllConsignmentNotePageState createState() => _GetAllConsignmentNotePageState();
}

class _GetAllConsignmentNotePageState extends StateMVC
{
  late ConsignmentNoteController _controller;

  _GetAllConsignmentNotePageState() : super(ConsignmentNoteController()) {_controller = controller as ConsignmentNoteController;}

  Widget appBarTitle = const Text("Накладная");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  @override
  void initState()
  {
    super.initState();
    _controller.getConsignmentNoteList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: appBarTitle,
        leading: IconButton(icon: const Icon(Icons.arrow_back),
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
                appBarTitle = const Text("Накладная");
              }
            });
          } ,),]
      ),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateConsignmentNotePage())); },
        tooltip: 'Добавить накладную',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is ConsignmentNoteResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ConsignmentNoteResultFailure)
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
      final _consignmentNoteList = (state as ConsignmentNoteGetListResultSuccess).consignmentNoteList;
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
                  itemCount: _consignmentNoteList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetConsignmentNotePage(id: _consignmentNoteList[index].getIdConsignmentNote!)));
                      },
                      child: ItemConsignmentNoteWidget(_consignmentNoteList[index]),
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


