import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/position/PutPositionPage.dart';
import '../../controller/PositionController.dart';
import '../../model/Position.dart';
import 'DeletePositionPage.dart';

class GetPositionPage extends StatefulWidget
{
  final int id;
  const GetPositionPage({Key? key, required this.id}) : super(key: key);

  @override
  GetPositionPageState createState() => GetPositionPageState(id);
}

class GetPositionPageState extends StateMVC
{
  PositionController? _controller;
  final int _id;

  GetPositionPageState(this._id) : super(PositionController()) {_controller = controller as PositionController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getPosition(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutPositionPage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeletePositionPage(_id)));
        if (value == true)
        {
          _controller?.deletePosition(_id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Должность удалена")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
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
      final _position = (state as PositionGetItemResultSuccess).position;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о должности №$_id"),
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
                  Text("Название: ${_position.getName} \n"
                      , style: const TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}