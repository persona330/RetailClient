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

import '../../controller/ShelfController.dart';
import '../../model/Shelf.dart';
import 'CreateShelfPage.dart';
import 'ItemShelfPage.dart';


class GetAllShelfPage extends StatefulWidget
{
  const GetAllShelfPage({Key? key}) : super(key: key);

  @override
  _GetAllShelfPageState createState() => _GetAllShelfPageState();
}

// Домашняя страница
class _GetAllShelfPageState extends StateMVC
{
  late ShelfController _controller;

  _GetAllShelfPageState() : super(ShelfController()) {_controller = controller as ShelfController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getShelfList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Полки"),
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
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateShelfPage())); },
        tooltip: 'Добавить полку',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is ShelfResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ShelfResultFailure)
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
      final _shelfList = (state as ShelfGetListResultSuccess).shelfList;
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
                  itemCount: _shelfList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetAddressPage(id: _shelfList[index].getIdShelf!)));
                      },
                      child: ItemShelfPage(_shelfList[index]),
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


