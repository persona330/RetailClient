import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/organization/CreateOrganizationPage.dart';

class ListAddressWidget extends StatefulWidget
{
  ListAddressWidget({Key? key}) : super(key: key);

  @override
  _ListAddressWidgetState createState() => _ListAddressWidgetState();
}

class _ListAddressWidgetState extends StateMVC
{
  late AddressController _controller;
  late Address _address;

  _ListAddressWidgetState() : super(AddressController()) {_controller = controller as AddressController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is AddressResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is AddressResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final addressList = (state as AddressGetListResultSuccess).addressList;
      _address = addressList[0];

      return DropdownButtonFormField(
          isExpanded: true,
          decoration: InputDecoration(labelText: "Адрес",),
          items: addressList.map((Address items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Address? item) {
            setState(() {
              _address = item!;
            });
            CreateOrganizationPage.of(context)?.setAddress(_address);
          }
      );
  }
  }

}