import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/test/CreatePostPage.dart';
import 'package:retail/page/SearchAddressPage.dart';
import 'package:retail/page/address/PutAddressPage.dart';

import '../../controller/SupplierController.dart';
import '../../model/Supplier.dart';
import 'DeleteSupplierPage.dart';

class GetSupplierPage extends StatefulWidget
{
  final int id;
  const GetSupplierPage({Key? key, required this.id}) : super(key: key);

  @override
  GetSupplierPageState createState() => GetSupplierPageState(id);
}

class GetSupplierPageState extends StateMVC
{
  SupplierController? _controller;
  final int _id;

  GetSupplierPageState(this._id) : super(SupplierController()) {_controller = controller as SupplierController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getSupplier(_id);
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
            pageBuilder: (BuildContext context, _, __)=> DeleteSupplierPage(_id)));
        if (value == true)
        {
          _controller?.deleteSupplier(_id);
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
    if (state is SupplierResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is SupplierResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _supplier = (state as SupplierGetItemResultSuccess).supplier;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о поставщике №${_id}"),
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
                  Text("Имя: ${_supplier.getName} \n"
                      "Должность: ${_supplier.getPosition.toString()} \n"
                      "Организация: ${_supplier.getOrganization.toString()}"
                      , style: TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}