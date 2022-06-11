import 'package:flutter/material.dart';
import '../../../model/Import.dart';

class ItemImportWidget extends StatelessWidget
{
  final Import import;

  ItemImportWidget(this.import);

  @override
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
          subtitle: const Text('Описание \n'),
      ),
    );
  }
}