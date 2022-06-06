import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/MeasurementController.dart';
import '../../model/Measurement.dart';
import 'CreateMeasurementPage.dart';
import 'GetMeasurementPage.dart';
import 'ItemMeasurementPage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllMeasurementPage extends StatefulWidget
{
  const GetAllMeasurementPage({Key? key}) : super(key: key);

  @override
  _GetAllMeasurementPageState createState() => _GetAllMeasurementPageState();
}

// Домашняя страница
class _GetAllMeasurementPageState extends StateMVC
{
  late MeasurementController _controller;

  _GetAllMeasurementPageState() : super(MeasurementController()) {_controller = controller as MeasurementController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getMeasurementList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Единицы измерения"),
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
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateMeasurementPage())); },
        tooltip: 'Создать единицу измерения',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is MeasurementResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is MeasurementResultFailure)
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
      final _measurementList = (state as MeasurementGetListResultSuccess).measurementList;
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
                  itemCount: _measurementList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetMeasurementPage(id: _measurementList[index].getIdMeasurement!)));
                      },
                      child: ItemMeasurementPage(_measurementList[index]),
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


