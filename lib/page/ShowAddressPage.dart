import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/CresteAddressPage.dart';
import 'package:retail/page/GetAddressPage.dart';
import 'package:retail/service/AddressService.dart';

class ShowAddressPage extends StatefulWidget
{
  const ShowAddressPage({Key? key, required this.id, required this.body}) : super(key: key);
  final int id;
  final String body;

  @override
  State<ShowAddressPage> createState() => _ShowAddressPageState();
}

class _ShowAddressPageState extends State<ShowAddressPage>
{
  @override
  void initState()
  {
    super.initState();
  }

  void _handleClick(String value)
  {
    switch (value)
    {
      case 'Создать':
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAddressPage()));
        break;
      case 'Изменить':
        break;
      case 'Найти':
        Navigator.push(context, MaterialPageRoute(builder: (context) => GetAddressPage()));
        break;
      case 'Удалить':
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
          title: Text("Информация о адресе №${widget.id}"),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: _handleClick, // функция при нажатии
              itemBuilder: (BuildContext context)
              {
                return {'Создать', 'Изменить', 'Найти', 'Удалить'}.map((String choice)
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
      body:  Scrollbar(
        child: Container(
          // this.left, this.top, this.right, this.bottom
          padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
          child: Column (
            children: [
              Text("${widget.body}", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}