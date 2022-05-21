import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Measurement.dart';

class ItemMeasurementPage extends StatelessWidget
{
  final Measurement measurement;

  ItemMeasurementPage(this.measurement);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${measurement.getIdMeasurement}"),
          title: Text('${measurement.getFullName}'),
          subtitle: Text(
          'Тело: \n'
          ),
          //trailing: Text('${address.getIdAddress}'),
      ),
    );
  }
}