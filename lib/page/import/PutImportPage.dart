import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/import/widget/PutListConsignmentNoteWidget.dart';
import 'package:retail/page/import/widget/PutListNomenclatureWidget.dart';
import '../../controller/ImportController.dart';
import '../../model/ConsignmentNote.dart';
import '../../model/Import.dart';
import '../../model/Nomenclature.dart';

class PutImportPage extends StatefulWidget
{
  final int id;
  const PutImportPage({Key? key, required this.id}) : super(key: key);

  @override
  PutImportPageState createState() => PutImportPageState(id);

  static PutImportPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutImportPageState? result =
    context.findAncestorStateOfType<PutImportPageState>();
    return result;
  }
}

class PutImportPageState extends StateMVC
{
  ImportController? _controller;
  final int _id;

  PutImportPageState(this._id) : super(ImportController()) {_controller = controller as ImportController;}

  final _quantityController = TextEditingController();
  final _costController = TextEditingController();
  final _vatController = TextEditingController();

  late Nomenclature _nomenclature;
  late ConsignmentNote _consignmentNote;

  Nomenclature getNomenclature(){return _nomenclature;}
  void setNomenclature(Nomenclature nomenclature){_nomenclature = nomenclature;}

  ConsignmentNote getConsignmentNote(){return _consignmentNote;}
  void setConsignmentNote(ConsignmentNote consignmentNote){_consignmentNote = consignmentNote;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getImport(_id);
  }

  @override
  void dispose()
  {
    _quantityController.dispose();
    _costController.dispose();
    _vatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is ImportResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ImportResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _import = (state as ImportGetItemResultSuccess).import;
      _quantityController.text = _import.getQuantity!.toString();
      _costController.text = _import.getCost!.toString();
      _vatController.text = _import.getVat!.toString();
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение привоза')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(labelText: "Количество"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _quantityController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(labelText: "Цена"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _costController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(labelText: "НДС"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _vatController,
                    textInputAction: TextInputAction.next,
                  ),
                  const Flexible(
                    flex: 1,
                    child: PutListConsignmentNoteWidget(),
                  ),
                  const Flexible(
                      flex: 2,
                      child: PutListNomenclatureWidget()
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Import _import1 = Import(idImport: _id, quantity: int.parse(_quantityController.text), cost: double.parse(_costController.text), vat: int.parse(_vatController.text), consignmentNote: getConsignmentNote(), nomenclature: getNomenclature());
                      _controller?.putImport(_import1, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is ImportAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Привоз изменен")));}
                      if (state is ImportResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is ImportResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                    },
                    child: const Text('Изменить'),
                  ),
                ]
            ),
          ),
        ),
      );
    }
  }

}