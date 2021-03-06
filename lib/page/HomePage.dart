import 'package:flutter/material.dart';
import 'package:retail/page/address/GetAllAddreessPage.dart';
import 'package:retail/page/communication/GetAllCommunicationPage.dart';
import 'package:retail/page/employee/GetAllEmployeePage.dart';
import 'package:retail/page/group/CatalogPage.dart';
import 'package:retail/page/store/GetAllStorePage.dart';
import '../model/Group.dart';
import 'consignment_note/GetAllConsignmentNotePage.dart';
import 'employee_store/GetAllEmployeeStorePage.dart';
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
    return Scaffold(
      // AppBar - верхняя панель
        appBar: AppBar(
            title: Text(widget.title),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => {print("Click on settings button")}
            ),
          ],
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
                leading: const Icon(Icons.account_circle),
                title: const Text('Накладная'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GetAllConsignmentNotePage())),
              ),
              ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Каталог товаров'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CatalogPage(group: Group(idGroup: 1, name: "Продукты", type: null)))),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Номенклатура'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GetAllNomenclaturePage())),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Организация'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GetAllOrganizationPage())),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Сотрудники'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GetAllEmployeePage())),
              ),
              ListTile(
                leading: const Icon(Icons.store),
                title: const Text('Склады'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GetAllStorePage())),
              ),
              ListTile(
                leading: const Icon(Icons.store),
                title: const Text('Адреса'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GetAllAddressPage())),
              ),
            ],
          ),
        ),
        // body - задает основное содержимое
        body: Column(),
    );
  }
}

