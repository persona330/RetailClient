import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Communication.dart';

class ItemCommunicationPage extends StatelessWidget
{
  final Communication communication;

  ItemCommunicationPage(this.communication);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${communication.getIdCommunication}"),
          title: Text('Средство связи'),
          subtitle: Text(
          'Тело: \n'
          ),
          //trailing: Text('${address.getIdAddress}'),
      ),
    );
  }
}