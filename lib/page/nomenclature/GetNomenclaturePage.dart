import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/nomenclature/PutNomenclaturePage.dart';
import '../../controller/NomenclatureController.dart';
import '../../model/Nomenclature.dart';
import 'DeleteNomenclaturePage.dart';

class GetNomenclaturePage extends StatefulWidget
{
  final int id;
  const GetNomenclaturePage({Key? key, required this.id}) : super(key: key);

  @override
  GetNomenclaturePageState createState() => GetNomenclaturePageState(id);
}

class GetNomenclaturePageState extends StateMVC
{
  NomenclatureController? _controller;
  final int _id;

  GetNomenclaturePageState(this._id) : super(NomenclatureController()) {_controller = controller as NomenclatureController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getNomenclature(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutNomenclaturePage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeleteNomenclaturePage(_id)));
        if (value == true)
        {
          _controller?.deleteNomenclature(_id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Номенклатура удалена")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is NomenclatureResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is NomenclatureResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _nomenclature = (state as NomenclatureGetItemResultSuccess).nomenclature;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация об номенклатуре №$_id"),
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
                  Text("Название: ${_nomenclature.getName} \n"
                      "Бренд: ${_nomenclature.getBrand} \n"
                      "Цена: ${_nomenclature.getCost} \n"
                      "Дата производства: ${_nomenclature.getProductionDate} \n"
                      "Срок годности: ${_nomenclature.getExpirationDate} \n"
                      "Вес: ${_nomenclature.getWeight} \n"
                      "Объем: ${_nomenclature.getSize} \n"
                      "Группа: ${_nomenclature.getGroup.toString()} \n"
                      "Производител: ${_nomenclature.getOrganization.toString()} \n"
                      "Единица измерения: ${_nomenclature.getMeasurement.toString()} \n"
                      "Ячейка: ${_nomenclature.getBox.toString()} \n"
                      "Условия хранения: ${_nomenclature.getStorageConditions.toString()} \n"
                      //"Объем: ${_address.getNation} "
                      , style: const TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}