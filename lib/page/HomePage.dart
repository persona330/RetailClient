import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/AddreessPage.dart';
import 'package:retail/page/CresteAddressPage.dart';
import 'package:retail/page/GetAddressPage.dart';
import 'package:retail/page/LIstPostPage.dart';
import 'package:retail/page/ListAddressPage.dart';
import 'package:retail/service/AddressService.dart';
import 'package:flutter/services.dart';


class HomePage extends StatefulWidget
{
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      // AppBar - верхняя панель
        appBar: AppBar(
            title: Text(widget.title),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
             const DrawerHeader(
                decoration: BoxDecoration( color: Colors.blue),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Адреса'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddressPage())),
              ),
              ListTile(
                leading: Icon(Icons.library_books),
                title: Text('Связи'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ListPostPage())),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ListAddressPage())),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
        // body - задает основное содержимое
        body: Column(),
    );
  }
}

