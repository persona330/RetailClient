import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/ConsignmentNote.dart';
import 'package:retail/model/Nomenclature.dart';
import 'package:retail/page/nomenclature/ListNomenclatureWidget.dart';
import '../../controller/ImportController.dart';
import '../../model/Import.dart';
import '../consignment_note/ListConsignmentNoteWidget.dart';

class CreateImportPage extends StatefulWidget
{
  const CreateImportPage({Key? key}) : super(key: key);

  @override
  _CreateImportPageState createState() => _CreateImportPageState();

  static _CreateImportPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateImportPageState? result =
    context.findAncestorStateOfType<_CreateImportPageState>();
    return result;
  }
}

class _CreateImportPageState extends StateMVC
{
  ImportController? _controller;

  _CreateImportPageState() : super(ImportController()) {_controller = controller as ImportController;}

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
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      appBar: AppBar(title: const Text('Создание привоза')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
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
                  child: ListConsignmentNoteWidget(),
                ),
                const Flexible(
                    flex: 2,
                    child: ListNomenclatureWidget()
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Import _import = Import(idImport: UniqueKey().hashCode, quantity: int.parse(_quantityController.text), cost: double.parse(_costController.text), vat: int.parse(_vatController.text), consignmentNote: getConsignmentNote(), nomenclature: getNomenclature());
                    _controller?.addImport(_import);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is ImportAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Добавлен")));}
                    if (state is ImportResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is ImportResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Отправить'),
                ),
              ],
            ),
          ),
      ),
    );
  }
}