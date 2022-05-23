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

import 'DeleteAddressPage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllAddressPage extends StatefulWidget
{
  const GetAllAddressPage({Key? key}) : super(key: key);

  @override
  _GetAllAddressPageState createState() => _GetAllAddressPageState();
}

// Домашняя страница
class _GetAllAddressPageState extends StateMVC
{
  late AddressController _controller;

  _GetAllAddressPageState() : super(AddressController()) {_controller = controller as AddressController;}

  final AddressService _addressService = AddressService();

  late Future <List<Address>> _futureAddresses;
  late Future <Address> _futureAddress;

  final _idAddressController = TextEditingController();

  late String _idAddress = "0";
  late String _idPost = "0";
  late int _idPost1 = 0;
  late String _bodyPost = "";
  var items = <int>[];

  _changeIdAddress() { setState(() => _idAddress = _idAddressController.text); }

  @override
  void initState()
  {
    super.initState();
    _controller.getAddresses();
    //items.add(_idPost1);
    //_futureAddress = _addressService.getAddress(int.parse(_idAddress));
    //_futureAddresses = _addressService.getAddresses();
    _idAddressController.addListener(_changeIdAddress);
  }

  @override
  void dispose()
  {
    _idAddressController.dispose();
    super.dispose();
  }

  // Вызывает перестроение виджета при изменении состояния через функцию build() в классе состояния
  void _f1() {setState(() {});}

  void _searchItem(int id)
  {
    if(id != 0)
    {
      return;
    }

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Адреса"),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
                onPressed: () { print("Click on settings button"); }
                ),
        ],
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAddressPage())); },
        tooltip: 'Создать адрес',
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
      final addressList = (state as AddressGetListResultSuccess).addressList;

      return Column(
        children: [
          Container(
            // this.left, this.top, this.right, this.bottom
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                _searchItem(int.parse(value));
              },
              controller: _idAddressController,
              decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))
              ),
            ),
          ),
          Expanded(
            child:
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                // ListView.builder создает элемент списка
                // только когда он видим на экране
                child: ListView.builder(
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetAddressPage(id: addressList[index].getIdAddress!)));
                      },
                      child: ItemAddressPage(addressList[index]),
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


