import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/address/PutAddressPage.dart';
import 'package:retail/page/import/PutImportPage.dart';
import '../../controller/ImportController.dart';
import '../../model/Import.dart';
import 'DeleteImportPage.dart';

class GetImportPage extends StatefulWidget
{
  final int id;
  const GetImportPage({Key? key, required this.id}) : super(key: key);

  @override
  GetImportPageState createState() => GetImportPageState(id);
}

class GetImportPageState extends StateMVC
{
  ImportController? _controller;
  final int _id;

  GetImportPageState(this._id) : super(ImportController()) {_controller = controller as ImportController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getImport(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutImportPage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeleteImportPage(_id)));
        if (value == true)
        {
          _controller?.deleteImport(_id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Привоз удален")));
          Navigator.of(context).pop();
        }
        break;
    }
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
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о привозе №$_id"),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: _handleClick, // функция при нажатии
                itemBuilder: (BuildContext context)
                {
                  return {'Изменить', 'Удалить'}.map((String choice)
                  {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: Scrollbar(
            child: Container(
              // this.left, this.top, this.right, this.bottom
              padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
              child: Column (
                children: [
                  Text("Количество: ${_import.getQuantity} \n"
                      "Цена: ${_import.getCost} \n"
                      "НДС: ${_import.getVat} \n"
                      "Накладная: ${_import.getConsignmentNote.toString()} \n"
                      "Номенклатура: ${_import.getNomenclature.toString()} "
                      , style: const TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}