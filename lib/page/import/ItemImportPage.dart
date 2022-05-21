import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Import.dart';

class ItemImportPage extends StatelessWidget
{
  final Import import;

  ItemImportPage(this.import);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${import.getIdImport}"),
          title: Text('${import.getQuantity}'),
          subtitle: Text(
          'Тело: \n'
          ),
      ),
    );
  }
}