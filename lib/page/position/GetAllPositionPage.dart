import 'package:flutter/material.dart';
import 'package:retail/page/address/GetAddressPage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/PositionController.dart';
import '../../model/Position.dart';
import 'CreatePositionPage.dart';
import 'ItemPositionPage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllPositionPage extends StatefulWidget
{
  const GetAllPositionPage({Key? key}) : super(key: key);

  //final String title;

  @override
  _GetAllPositionPageState createState() => _GetAllPositionPageState();
}

// Домашняя страница
class _GetAllPositionPageState extends StateMVC
{
  late PositionController _controller;

  _GetAllPositionPageState() : super(PositionController()) {_controller = controller as PositionController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getPositionList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Должность"),
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
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePositionPage())); },
        tooltip: 'Добавить должность',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is PositionResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is PositionResultFailure)
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
      final _positionList = (state as PositionGetListResultSuccess).positionList;
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
                  itemCount: _positionList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetAddressPage(id: _positionList[index].getIdPosition!)));
                      },
                      child: ItemPositionPage(_positionList[index]),
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

