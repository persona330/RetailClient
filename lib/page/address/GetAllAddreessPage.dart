import 'package:flutter/material.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/address/CreateAddressPage.dart';
import 'package:retail/page/address/GetAddressPage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/address/widget/ItemAddressWidget.dart';

class GetAllAddressPage extends StatefulWidget
{
  const GetAllAddressPage({Key? key}) : super(key: key);

  @override
  _GetAllAddressPageState createState() => _GetAllAddressPageState();

  static _GetAllAddressPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _GetAllAddressPageState? result =
    context.findAncestorStateOfType<_GetAllAddressPageState>();
    return result;
  }
}

// Домашняя страница
class _GetAllAddressPageState extends StateMVC
{
  late AddressController _controller;

  _GetAllAddressPageState() : super(AddressController()) {_controller = controller as AddressController;}

  Widget appBarTitle = const Text("Адрес");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  refresh() {
    setState(() {});
  }

  @override
  void initState()
  {
    super.initState();
    _controller.getAddresses();
  }

  @override
  void dispose()
  {
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: appBarTitle,
        leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(icon: actionIcon,onPressed:()
          {
            setState(() {
              if ( actionIcon.icon == Icons.search)
              {
                actionIcon = const Icon(Icons.close);
                appBarTitle = const TextField(
                  style: TextStyle(color: Colors.white,),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Поиск...",
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                );}
              else {
                actionIcon = const Icon(Icons.search);
                appBarTitle = const Text("Адрес");
              }
            });
          } ,),]
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAddressPage())); },
        tooltip: 'Добавить адрес',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
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
      // отображаем список постов
      final _addressList = (state as AddressGetListResultSuccess).addressList;
      return Column(
        children: [
          Expanded(
            child:
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: _addressList.length,
                  itemBuilder: (context, index)
                  {
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetAddressPage(id: _addressList[index].getIdAddress!)));
                      },
                      child: ItemAddressWidget(_addressList[index]),
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


