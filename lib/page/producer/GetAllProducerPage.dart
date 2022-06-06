import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/ProducerController.dart';
import '../../model/Producer.dart';
import 'CreateProducerPage.dart';
import 'GetProducerPage.dart';
import 'ItemProducerPage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllProducerPage extends StatefulWidget
{
  const GetAllProducerPage({Key? key}) : super(key: key);

  //final String title;

  @override
  _GetAllProducerPageState createState() => _GetAllProducerPageState();
}

// Домашняя страница
class _GetAllProducerPageState extends StateMVC
{
  late ProducerController _controller;

  _GetAllProducerPageState() : super(ProducerController()) {_controller = controller as ProducerController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getProducerList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Производитель"),
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
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateProducerPage())); },
        tooltip: 'Добавить производителя',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is ProducerResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProducerResultFailure)
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
      final _producerList = (state as ProducerGetListResultSuccess).producerList;
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
                  itemCount: _producerList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetProducerPage(id: _producerList[index].getIdProducer!)));
                      },
                      child: ItemProducerPage(_producerList[index]),
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


