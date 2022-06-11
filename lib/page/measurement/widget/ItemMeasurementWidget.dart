import 'package:flutter/material.dart';
import '../../../model/Measurement.dart';

class ItemMeasurementWidget extends StatelessWidget
{
  final Measurement measurement;

  ItemMeasurementWidget(this.measurement);

  @override
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
          subtitle: const Text('Описание'),
          //trailing: Text('${address.getIdAddress}'),
      ),
    );
  }
}