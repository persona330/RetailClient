import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/test/CreatePostPage.dart';
import 'package:retail/page/SearchAddressPage.dart';
import 'package:retail/page/address/PutAddressPage.dart';

import '../../controller/StillageController.dart';
import '../../model/Stillage.dart';
import 'DeleteStillagePage.dart';

class GetStillagePage extends StatefulWidget
{
  final int id;
  const GetStillagePage({Key? key, required this.id}) : super(key: key);


  @override
  GetStillagePageState createState() => GetStillagePageState(id);
}

class GetStillagePageState extends StateMVC
{
  StillageController? _controller;
  final int _id;

  GetStillagePageState(this._id) : super(StillageController()) {_controller = controller as StillageController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getStillage(_id);
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
            pageBuilder: (BuildContext context, _, __)=> DeleteStillagePage(_id)));
        if (value == true)
        {
          _controller?.deleteStillage(_id);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Удален")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is StillageResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StillageResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _stillage = (state as StillageGetItemResultSuccess).stillage;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о стеллаже №${_id}"),
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
                  Text("Номер: ${_stillage.getNumber} \n"
                      "Вместимость: ${_stillage.getSize} \n"
                      "Зона: ${_stillage.getArea.toString()}"
                      , style: TextStyle(fontSize: 22)),

                ],
              ),
            ),
          ),
      );
    }
  }
}