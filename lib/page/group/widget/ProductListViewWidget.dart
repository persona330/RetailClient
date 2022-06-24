import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/nomenclature/GetNomenclaturePage.dart';
import '../../../controller/NomenclatureController.dart';
import '../../../model/Group.dart';
import '../../../model/Nomenclature.dart';
import '../../nomenclature/widget/ItemNomenclatureWidget.dart';

class NomenclatureListViewWidget extends StatefulWidget
{
  final Group group;
  const NomenclatureListViewWidget({Key? key, required this.group}) : super(key: key);

  @override
  _NomenclatureListViewWidgetState createState() => _NomenclatureListViewWidgetState(group);
}

class _NomenclatureListViewWidgetState extends StateMVC
{
  late NomenclatureController _controller;
  late Group _group;

  _NomenclatureListViewWidgetState(this._group) : super(NomenclatureController()) {_controller = controller as NomenclatureController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getNomenclatureList();
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller.currentState;
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
      final _nomenclatureList = (state as NomenclatureGetListResultSuccess).nomenclatureList;
      List<Nomenclature> list = [];
      for(var idx in _nomenclatureList)
      {
        if (idx.getGroup?.getIdGroup == _group.getIdGroup)
        {
          list.add(idx);
        }
      }
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  GetNomenclaturePage(id: list[index].getIdNomenclature!)));
            },
            child: ItemNomenclatureWidget(list[index]),
          );
        },
      );
    }
  }
}



