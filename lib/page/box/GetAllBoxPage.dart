import 'package:flutter/material.dart';
import 'package:retail/page/address/CreateAddressPage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/BoxController.dart';
import '../../model/Box.dart';
import 'GetBoxPage.dart';
import 'ItemBoxPage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllBoxPage extends StatefulWidget
{
  const GetAllBoxPage({Key? key}) : super(key: key);

  @override
  _GetAllBoxPageState createState() => _GetAllBoxPageState();
}

// Домашняя страница
class _GetAllBoxPageState extends StateMVC
{
  late BoxController _controller;

  _GetAllBoxPageState() : super(BoxController()) {_controller = controller as BoxController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getBoxList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Ячейки"),
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
        tooltip: 'Добавить ячейку',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is BoxResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is BoxResultFailure)
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
      final _boxList = (state as BoxGetListResultSuccess).boxList;
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
                  itemCount: _boxList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetBoxPage(id: _boxList[index].getIdBox!)));
                      },
                      child: ItemBoxPage(_boxList[index]),
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


