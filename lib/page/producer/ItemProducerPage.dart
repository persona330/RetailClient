import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Producer.dart';

class ItemProducerPage extends StatelessWidget
{
  final Producer producer;

  ItemProducerPage(this.producer);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${producer.getIdProducer}"),
          title: Text('${producer.getName}'),
          subtitle: Text(
          'Тело: \n'
          ),
      ),
    );
  }
}