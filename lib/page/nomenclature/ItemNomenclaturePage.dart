import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Nomenclature.dart';

class ItemNomenclaturePage extends StatelessWidget
{
  final Nomenclature nomenclature;

  ItemNomenclaturePage(this.nomenclature);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${nomenclature.getIdNomenclature}"),
          title: Text('${nomenclature.getName}'),
          subtitle: Text(
          'Тело: \n'
          ),
      ),
    );
  }
}