import 'package:flutter/material.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/controller/PostController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/model/Post.dart';
import 'package:retail/page/address/CreateAddressPage.dart';
import 'package:retail/page/address/ItemAddressPage.dart';
import 'package:retail/page/address/GetAddressPage.dart';
import 'package:retail/page/organization/CreateOrganizationPage.dart';
import 'package:retail/service/AddressService.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/service/PostService.dart';

import '../../controller/OrganizationController.dart';
import '../../model/Organization.dart';
import 'GetOrganizationPage.dart';
import 'ItemOrganizationPage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllOrganizationPage extends StatefulWidget
{
  const GetAllOrganizationPage({Key? key}) : super(key: key);

  @override
  _GetAllOrganizationPageState createState() => _GetAllOrganizationPageState();
}

// Домашняя страница
class _GetAllOrganizationPageState extends StateMVC
{
  late OrganizationController _controller;

  _GetAllOrganizationPageState() : super(OrganizationController()) {_controller = controller as OrganizationController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getOrganizationList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Организация"),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
                onPressed: () => {
                  print("Click on settings button")
                }
                ),
        ],
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateOrganizationPage())); },
        tooltip: 'Добавить организацию',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is OrganizationResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is OrganizationResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      // отображаем список постов
      final organizationList = (state as OrganizationGetListResultSuccess).organizationList;
      return Column(
        children: [
          Expanded(
            child:
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                // ListView.builder создает элемент списка
                // только когда он видим на экране
                child: ListView.builder(
                  itemCount: organizationList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetOrganizationPage(id: organizationList[index].getIdOrganization!)));
                      },
                      child: ItemOrganizationPage(organizationList[index]),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
  }
  }
}


