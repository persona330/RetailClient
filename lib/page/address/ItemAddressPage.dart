import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

class ItemAddressPage extends StatelessWidget
{
  final Address address;

  ItemAddressPage(this.address);

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
          subtitle: Text(
          'Тело: ${address.getRegion}\n'
          ),
      ),
    );
  }
}