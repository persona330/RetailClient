import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/test/CreatePostPage.dart';
import 'package:retail/page/SearchAddressPage.dart';
import 'package:retail/page/address/PutAddressPage.dart';

import '../../controller/StorageConditionsController.dart';
import '../../model/StorageConditions.dart';
import 'DeleteStorageConditionsPage.dart';

class GetStorageConditionsPage extends StatefulWidget
{
  final int id;
  const GetStorageConditionsPage({Key? key, required this.id}) : super(key: key);

  @override
  GetStorageConditionsPageState createState() => GetStorageConditionsPageState(id);
}

class GetStorageConditionsPageState extends StateMVC
{
  StorageConditionsController? _controller;
  final int _id;

  GetStorageConditionsPageState(this._id) : super(StorageConditionsController()) {_controller = controller as StorageConditionsController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getStorageConditions(_id);
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
            pageBuilder: (BuildContext context, _, __)=> DeleteStorageConditionsPage(_id)));
        if (value == true)
        {
          _controller?.deleteStorageConditions(_id);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Удалены")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is StorageConditionsResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StorageConditionsResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _storageConditions = (state as StorageConditionsGetItemResultSuccess).storageConditions;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация об условиях хранения №${_id}"),
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
                  Text("Название: ${_storageConditions.getName} \n"
                      "Температура: ${_storageConditions.getTemperature} ${_storageConditions.getMeasurementTemperature} \n"
                      "Влажность: ${_storageConditions.getHumidity} ${_storageConditions.getMeasurementHumidity}\n"
                      "Усвещенность: ${_storageConditions.getIllumination} ${_storageConditions.getMeasurementIllumination} "
                      , style: TextStyle(fontSize: 22)),

                ],
              ),
            ),
          ),
      );
    }
  }
}