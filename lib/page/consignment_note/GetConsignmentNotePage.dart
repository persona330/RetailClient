import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/test/CreatePostPage.dart';
import 'package:retail/page/SearchAddressPage.dart';
import 'package:retail/page/address/PutAddressPage.dart';

import '../../controller/ConsignmentNoteController.dart';
import '../../model/ConsignmentNote.dart';
import 'DeleteConsignmentNotePage.dart';

class GetConsignmentNotePage extends StatefulWidget
{
  final int id;
  const GetConsignmentNotePage({Key? key, required this.id}) : super(key: key);

  @override
  GetConsignmentNotePageState createState() => GetConsignmentNotePageState(id);
}

class GetConsignmentNotePageState extends StateMVC
{
  ConsignmentNoteController? _controller;
  final int _id;

  GetConsignmentNotePageState(this._id) : super(ConsignmentNoteController()) {_controller = controller as ConsignmentNoteController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getConsignmentNote(_id);
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
            pageBuilder: (BuildContext context, _, __)=> DeleteConsignmentNotePage(_id)));
        if (value == true)
        {
          _controller?.deleteConsignmentNote(_id);
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
    if (state is ConsignmentNoteResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ConsignmentNoteResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _consignmentNote = (state as ConsignmentNoteGetItemResultSuccess).consignmentNote;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация об накладной №${_id}"),
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
                  Text("Номер: ${_consignmentNote.getNumber} \n"
                      "Дата прибытия: ${_consignmentNote.getArrivalDate} \n"
                      "Поставщик: ${_consignmentNote.getSupplier.toString()} \n"
                      "Сотрудник склада: ${_consignmentNote.getEmployeeStore.toString()} \n"
                      "На возврат: ${_consignmentNote.getForReturn}"
                      , style: TextStyle(fontSize: 22)),

                ],
              ),
            ),
          ),
      );
    }
  }
}