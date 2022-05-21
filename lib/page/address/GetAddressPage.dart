import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/address/DeleteAddressPage.dart';
import 'package:retail/page/test/CreatePostPage.dart';
import 'package:retail/page/SearchAddressPage.dart';
import 'package:retail/page/address/PutAddressPage.dart';

class GetAddressPage extends StatefulWidget
{
  final int id;
  const GetAddressPage({Key? key, required this.id}) : super(key: key);


  @override
  GetAddressPageState createState() => GetAddressPageState(id);
}

class GetAddressPageState extends StateMVC
{
  AddressController? _controller;
  final int _id;

  GetAddressPageState(this._id) : super(AddressController()) {_controller = controller as AddressController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getAddress(_id);
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
            pageBuilder: (BuildContext context, _, __)=> DeleteAddressPage(_id)));
        if (value == true)
        {
          _controller?.deleteAddress(_id);
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
    if (state is AddressResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is AddressResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _address = (state as AddressGetItemResultSuccess).address;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о адресе №${_id}"),
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
                  Text("Квартира: ${_address.getApartment} \n"
                      "Подъезд: ${_address.getEntrance} \n"
                      "Дом: ${_address.getHouse} \n"
                      "Улица ${_address.getStreet} \n"
                      "Регион: ${_address.getRegion} \n"
                      "Город: ${_address.getCity} \n"
                      "Страна: ${_address.getNation} "
                      , style: TextStyle(fontSize: 22)),

                ],
              ),
            ),
          ),
      );
    }
  }
}