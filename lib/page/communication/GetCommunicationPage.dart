import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/test/CreatePostPage.dart';
import 'package:retail/page/SearchAddressPage.dart';
import 'package:retail/page/address/PutAddressPage.dart';

import '../../controller/CommunicationController.dart';
import '../../model/Communication.dart';
import 'DeleteCommunicationPage.dart';

class GetCommunicationPage extends StatefulWidget
{
  final int id;
  const GetCommunicationPage({Key? key, required this.id}) : super(key: key);


  @override
  GetCommunicationPageState createState() => GetCommunicationPageState(id);
}

class GetCommunicationPageState extends StateMVC
{
  CommunicationController? _controller;
  final int _id;

  GetCommunicationPageState(this._id) : super(CommunicationController()) {_controller = controller as CommunicationController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getCommunication(_id);
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
            pageBuilder: (BuildContext context, _, __)=> DeleteCommunicationPage(_id)));
        if (value == true)
        {
          _controller?.deleteCommunication(_id);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Удалено")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is CommunicationResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CommunicationResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _communication = (state as CommunicationGetItemResultSuccess).communication;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о средстве связи №${_id}"),
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
                  Text("Электронный адрес: ${_communication.getEmail} \n"
                      "Номер телефона: ${_communication.getPhone}"
                      , style: TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}