import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

class ItemAddressWidget extends StatelessWidget
{
  final Address address;

  ItemAddressWidget(this.address);

  @override
  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${address.getIdAddress}"),
          title: Text('${address.getNation}'),
          subtitle: const Text('Описание \n'),
      ),
    );
  }
}