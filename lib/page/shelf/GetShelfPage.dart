import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/ShelfController.dart';
import '../../model/Shelf.dart';
import 'DeleteShelfPage.dart';
import 'PutShelfPage.dart';

class GetShelfPage extends StatefulWidget
{
  final int id;
  const GetShelfPage({Key? key, required this.id}) : super(key: key);

  @override
  GetShelfPageState createState() => GetShelfPageState(id);
}

class GetShelfPageState extends StateMVC
{
  ShelfController? _controller;
  final int _id;

  GetShelfPageState(this._id) : super(ShelfController()) {_controller = controller as ShelfController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getShelf(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutShelfPage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeleteShelfPage(_id)));
        if (value == true)
        {
          _controller?.deleteShelf(_id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Полка удалена")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is ShelfResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ShelfResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _shelf = (state as ShelfGetItemResultSuccess).shelf;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о полке №$_id"),
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
                  Text("Номер: ${_shelf.getNumber} \n"
                      "Вместимость: ${_shelf.getSize}"
                      , style: const TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}