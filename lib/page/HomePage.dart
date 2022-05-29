import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/address/CreateAddressPage.dart';
import 'package:retail/page/SearchAddressPage.dart';
import 'package:retail/page/address/GetAllAddreessPage.dart';
import 'package:retail/page/communication/GetAllCommunicationPage.dart';
import 'package:retail/page/store/GetAllStorePage.dart';
import 'package:retail/page/test/LIstPostPage.dart';
import 'package:retail/page/ListAddressPage.dart';
import 'package:retail/service/AddressService.dart';
import 'package:flutter/services.dart';
import 'consignment_note/GetAllConsignmentNotePage.dart';
import 'group/GetAllGroupPage.dart';
import 'nomenclature/GetAllNomenclaturePage.dart';
import 'organization/GetAllOrganizationPage.dart';


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
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Накладная'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GetAllConsignmentNotePage())),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Каталог товаров'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GetAllGroupPage())),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Номенклатура'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GetAllNomenclaturePage())),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Организация'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GetAllOrganizationPage())),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Склады'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GetAllStorePage())),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Адреса'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GetAllAddressPage())),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Средства связи'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GetAllCommunicationPage())),
              ),
            ],
          ),
        ),
        // body - задает основное содержимое
        body: Column(),
    );
  }
}

