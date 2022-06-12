import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/StoreController.dart';
import '../../model/Store.dart';
import 'DeleteStorePage.dart';
import 'PutStorePage.dart';

class GetStorePage extends StatefulWidget
{
  final int id;
  const GetStorePage({Key? key, required this.id}) : super(key: key);

  @override
  GetStorePageState createState() => GetStorePageState(id);
}

class GetStorePageState extends StateMVC
{
  StoreController? _controller;
  final int _id;

  GetStorePageState(this._id) : super(StoreController()) {_controller = controller as StoreController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getStore(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutStorePage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeleteStorePage(_id)));
        if (value == true)
        {
          _controller?.deleteStore(_id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Склад удален")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is StoreResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StoreResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _store = (state as StoreGetItemResultSuccess).store;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о складе №$_id"),
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
                  Text("Название: ${_store.getName} \n"
                      "Вместимость: ${_store.getTotalCapacity} \n"
                      "Организация: ${_store.getOrganization} \n"
                      "Адрес: ${_store.address.toString()}"
                      , style: const TextStyle(fontSize: 22)),

                ],
              ),
            ),
          ),
      );
    }
  }
}