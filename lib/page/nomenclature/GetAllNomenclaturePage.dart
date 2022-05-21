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

import '../../controller/NomenclatureController.dart';
import '../../model/Nomenclature.dart';
import 'CreateNomenclaturePage.dart';
import 'GetNomenclaturePage.dart';
import 'ItemNomenclaturePage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllNomenclaturePage extends StatefulWidget
{
  const GetAllNomenclaturePage({Key? key}) : super(key: key);

  //final String title;

  @override
  _GetAllNomenclaturePageState createState() => _GetAllNomenclaturePageState();
}

// Домашняя страница
class _GetAllNomenclaturePageState extends StateMVC
{
  late NomenclatureController _controller;

  _GetAllNomenclaturePageState() : super(NomenclatureController()) {_controller = controller as NomenclatureController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getNomenclatureList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Номенклатура"),
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
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNomenclaturePage())); },
        tooltip: 'Добавить номенклатуру',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is NomenclatureResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is NomenclatureResultFailure)
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
      final nomenclatureList = (state as NomenclatureGetListResultSuccess).nomenclatureList;
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
                  itemCount: nomenclatureList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetNomenclaturePage(id: nomenclatureList[index].getIdNomenclature!)));
                      },
                      child: ItemNomenclaturePage(nomenclatureList[index]),
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


