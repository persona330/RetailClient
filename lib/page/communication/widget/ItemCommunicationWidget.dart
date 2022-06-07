import 'package:flutter/material.dart';
import '../../../model/Communication.dart';

class ItemCommunicationWidget extends StatelessWidget
{
  final Communication communication;

  ItemCommunicationWidget(this.communication);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${communication.getIdCommunication}"),
          title: const Text('Средство связи'),
          subtitle: const Text('Описание \n'),
          //trailing: Text('${address.getIdAddress}'),
      ),
    );
  }
}