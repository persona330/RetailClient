import 'package:flutter/material.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/controller/PostController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/model/Post.dart';
import 'package:retail/page/address/CreateAddressPage.dart';
import 'package:retail/page/address/ItemAddressPage.dart';
import 'package:retail/page/address/GetAddressPage.dart';
import 'package:retail/service/AddressService.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/service/PostService.dart';

import '../../controller/SupplierController.dart';
import '../../model/Supplier.dart';
import 'CreateSupplierPage.dart';
import 'GetSupplierPage.dart';
import 'ItemSupplierPage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllSupplierPage extends StatefulWidget
{
  const GetAllSupplierPage({Key? key}) : super(key: key);

  @override
  _GetAllSupplierPageState createState() => _GetAllSupplierPageState();
}

// Домашняя страница
class _GetAllSupplierPageState extends StateMVC
{
  late SupplierController _controller;

  _GetAllSupplierPageState() : super(SupplierController()) {_controller = controller as SupplierController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getSupplierList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Поставщики"),
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
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateSupplierPage())); },
        tooltip: 'Добавить поставщика',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
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
      // отображаем список постов
      final _supplierList = (state as SupplierGetListResultSuccess).supplierList;
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
                  itemCount: _supplierList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetSupplierPage(id: _supplierList[index].getIdSupplier!)));
                      },
                      child: ItemSupplierPage(_supplierList[index]),
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


