import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/MeasurementController.dart';
import '../../model/Measurement.dart';
import 'DeleteMeasurementPage.dart';
import 'PutMeasurementPage.dart';

class GetMeasurementPage extends StatefulWidget
{
  final int id;
  const GetMeasurementPage({Key? key, required this.id}) : super(key: key);

  @override
  GetMeasurementPageState createState() => GetMeasurementPageState(id);
}

class GetMeasurementPageState extends StateMVC
{
  MeasurementController? _controller;
  final int _id;

  GetMeasurementPageState(this._id) : super(MeasurementController()) {_controller = controller as MeasurementController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getMeasurement(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutMeasurementPage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeleteMeasurementPage(_id)));
        if (value == true)
        {
          _controller?.deleteMeasurement(_id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Единица измерения удалена")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
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
      final _measurement = (state as MeasurementGetItemResultSuccess).measurement;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация об единице измерения №$_id"),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: _handleClick, // функция при нажатии
                itemBuilder: (BuildContext context)
                {
                  return {'Изменить', 'Удалить'}.map((String choice)
                  {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: Scrollbar(
            child: Container(
              // this.left, this.top, this.right, this.bottom
              padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
              child: Column (
                children: [
                  Text("Сокращение: ${_measurement.getName} \n"
                      "Полное название: ${_measurement.getFullName}"
                      , style: const TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}