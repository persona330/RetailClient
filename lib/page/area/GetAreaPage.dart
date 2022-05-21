import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/test/CreatePostPage.dart';
import 'package:retail/page/SearchAddressPage.dart';
import 'package:retail/page/address/PutAddressPage.dart';

import '../../controller/AreaController.dart';
import '../../model/Area.dart';
import 'DeleteAreaPage.dart';

class GetAreaPage extends StatefulWidget
{
  final int id;
  const GetAreaPage({Key? key, required this.id}) : super(key: key);

  @override
  GetAreaPageState createState() => GetAreaPageState(id);
}

class GetAreaPageState extends StateMVC
{
  AreaController? _controller;
  final int _id;

  GetAreaPageState(this._id) : super(AreaController()) {_controller = controller as AreaController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getArea(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutAddressPage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeleteAreaPage(_id)));
        if (value == true)
        {
          _controller?.deleteArea(_id);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Удалена")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is AreaResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is AreaResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _area = (state as AreaGetItemResultSuccess).area;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о зоне хранения №${_id}"),
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
                  Text("Название: ${_area.getName} \n"
                      "Вместимость: ${_area.getCapacity} \n"
                      , style: TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}