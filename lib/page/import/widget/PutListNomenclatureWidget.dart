import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/import/CreateImportPage.dart';
import '../../../controller/NomenclatureController.dart';
import '../../../model/Nomenclature.dart';

class PutListNomenclatureWidget extends StatefulWidget
{
  const PutListNomenclatureWidget({Key? key}) : super(key: key);

  @override
  _PutListNomenclatureWidgetState createState() => _PutListNomenclatureWidgetState();
}

class _PutListNomenclatureWidgetState extends StateMVC
{
  late NomenclatureController _controller;
  late Nomenclature _nomenclature;

  _PutListNomenclatureWidgetState() : super(NomenclatureController()) {_controller = controller as NomenclatureController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getNomenclatureList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is NomenclatureResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is NomenclatureResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _nomenclatureList = (state as NomenclatureGetListResultSuccess).nomenclatureList;
      _nomenclature = _nomenclatureList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Номенклатура",),
          items: _nomenclatureList.map((Nomenclature items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Nomenclature? item) {
            setState(() {_nomenclature = item!;});
            //CreateImportPage.of(context)?.setNomenclature(_nomenclature);
          }
      );
  }
  }

}