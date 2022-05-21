import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/test/CreatePostPage.dart';
import 'package:retail/page/SearchAddressPage.dart';
import 'package:retail/page/address/PutAddressPage.dart';

import '../../controller/ProducerController.dart';
import '../../model/Producer.dart';
import 'DeleteProducerPage.dart';

class GetProducerPage extends StatefulWidget
{
  final int id;
  const GetProducerPage({Key? key, required this.id}) : super(key: key);

  @override
  GetProducerPageState createState() => GetProducerPageState(id);
}

class GetProducerPageState extends StateMVC
{
  ProducerController? _controller;
  final int _id;

  GetProducerPageState(this._id) : super(ProducerController()) {_controller = controller as ProducerController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getProducer(_id);
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
            pageBuilder: (BuildContext context, _, __)=> DeleteProducerPage(_id)));
        if (value == true)
        {
          _controller?.deleteProducer(_id);
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
      final _producer = (state as ProducerGetItemResultSuccess).producer;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о производителе №${_id}"),
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
                  Text("Название: ${_producer.getName} \n"
                      , style: TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}