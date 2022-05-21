import 'package:flutter/material.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/address/CreateAddressPage.dart';
import 'package:retail/page/address/ItemAddressPage.dart';
import 'package:retail/page/address/GetAddressPage.dart';
import 'package:retail/service/AddressService.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../controller/StillageController.dart';
import '../../model/Stillage.dart';
import 'CreateStillagePage.dart';
import 'GetStillagePage.dart';
import 'ItemStillagePage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllStillagePage extends StatefulWidget
{
  const GetAllStillagePage({Key? key}) : super(key: key);

  @override
  _GetAllStillagePageState createState() => _GetAllStillagePageState();
}

// Домашняя страница
class _GetAllStillagePageState extends StateMVC
{
  late StillageController _controller;

  _GetAllStillagePageState() : super(StillageController()) {_controller = controller as StillageController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getStillageList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Стеллажи"),
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
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateStillagePage())); },
        tooltip: 'Добавить стеллаж',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is StillageResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StillageResultFailure)
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
      final _stillageList = (state as StillageGetListResultSuccess).stillageList;
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
                  itemCount: _stillageList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetStillagePage(id: _stillageList[index].getIdStillage!)));
                      },
                      child: ItemStillagePage(_stillageList[index]),
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


