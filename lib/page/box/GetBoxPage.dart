import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/box/PutBoxPage.dart';
import '../../controller/BoxController.dart';
import '../../model/Box.dart';
import 'DeleteBoxPage.dart';

class GetBoxPage extends StatefulWidget
{
  final int id;
  const GetBoxPage({Key? key, required this.id}) : super(key: key);

  @override
  GetBoxPageState createState() => GetBoxPageState(id);
}

class GetBoxPageState extends StateMVC
{
  BoxController? _controller;
  final int _id;

  GetBoxPageState(this._id) : super(BoxController()) {_controller = controller as BoxController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getBox(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutBoxPage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeleteBoxPage(_id)));
        if (value == true)
        {
          _controller?.deleteBox(_id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ячейка удалена")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
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
      final _box = (state as BoxGetItemResultSuccess).box;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация об ячейки №$_id"),
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
                  Text("Номер: ${_box.getNumber} \n"
                      "Вместимость: ${_box.getSize} \n"
                      "Полка: ${_box.getShelf.toString()} \n"
                      "Вертикальная секция: ${_box.getVerticalSections.toString()} \n"
                      , style: const TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}