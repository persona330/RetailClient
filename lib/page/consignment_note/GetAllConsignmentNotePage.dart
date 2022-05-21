import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/ConsignmentNoteController.dart';
import '../../model/ConsignmentNote.dart';
import '../../service/ConsignmentNoteService.dart';
import 'CreateConsignmentNotePage.dart';
import 'GetConsignmentNotePage.dart';
import 'ItemConsignmentNotePage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllConsignmentNotePage extends StatefulWidget
{
  const GetAllConsignmentNotePage({Key? key}) : super(key: key);

  @override
  _GetAllConsignmentNotePageState createState() => _GetAllConsignmentNotePageState();
}

// Домашняя страница
class _GetAllConsignmentNotePageState extends StateMVC
{
  late ConsignmentNoteController _controller;

  _GetAllConsignmentNotePageState() : super(ConsignmentNoteController()) {_controller = controller as ConsignmentNoteController;}

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
        title: Text("Накладная"),
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
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateConsignmentNotePage())); },
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
                padding: EdgeInsets.all(10),
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
                      child: ItemConsignmentNotePage(_consignmentNoteList[index]),
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


