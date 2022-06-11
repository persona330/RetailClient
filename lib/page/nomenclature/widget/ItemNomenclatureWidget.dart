import 'package:flutter/material.dart';
import '../../../model/Nomenclature.dart';

class ItemNomenclatureWidget extends StatelessWidget
{
  final Nomenclature nomenclature;

  ItemNomenclatureWidget(this.nomenclature);

  @override
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
          subtitle: const Text('Описание \n'),
      ),
    );
  }
}