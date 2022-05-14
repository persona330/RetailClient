import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/controller/PostController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/model/Post.dart';
import 'package:retail/page/address/ItemAddressPage.dart';
import 'package:retail/page/test/ItemPostPage.dart';
import 'package:retail/page/address/GetAddressPage.dart';

class ListAddressPage extends StatefulWidget
{
  @override
  _ListAddressPageState createState() => _ListAddressPageState();
}

// не забываем расширяться от StateMVC
class _ListAddressPageState extends StateMVC
{
  late AddressController _controller;

  _ListAddressPageState() : super(AddressController()) {_controller = controller as AddressController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getAddresses();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
          title: Text("Адреса"),
        ),
        body: _buildContent()
    );
  }

  Widget _buildContent() {
    // первым делом получаем текущее состояние
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
      return Padding(
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
      );
    }
  }


}