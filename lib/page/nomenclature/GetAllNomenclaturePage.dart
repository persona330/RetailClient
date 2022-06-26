import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/NomenclatureController.dart';
import '../../model/Nomenclature.dart';
import 'CreateNomenclaturePage.dart';
import 'GetNomenclaturePage.dart';
import 'widget/ItemNomenclatureWidget.dart';

class GetAllNomenclaturePage extends StatefulWidget
{
  const GetAllNomenclaturePage({Key? key}) : super(key: key);

  @override
  _GetAllNomenclaturePageState createState() => _GetAllNomenclaturePageState();
}

class _GetAllNomenclaturePageState extends StateMVC
{
  late NomenclatureController _controller;

  _GetAllNomenclaturePageState() : super(NomenclatureController()) {_controller = controller as NomenclatureController;}

  Widget appBarTitle = const Text("Номенклатуры");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  @override
  void initState()
  {
    super.initState();
    _controller.getNomenclatureList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: appBarTitle,
        leading: IconButton(icon:const Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(icon: actionIcon,onPressed:()
          {
            setState(() {
              if ( actionIcon.icon == Icons.search)
              {
                actionIcon = const Icon(Icons.close);
                appBarTitle = const TextField(
                  style: TextStyle(color: Colors.white,),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Поиск...",
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                );}
              else {
                actionIcon = const Icon(Icons.search);
                appBarTitle = const Text("Номенклатуры");
              }
            });
          } ,),]
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateNomenclaturePage())); },
        tooltip: 'Добавить номенклатуру',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
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
      // отображаем список постов
      final nomenclatureList = (state as NomenclatureGetListResultSuccess).nomenclatureList;
      return Column(
        children: [
          Expanded(
            child:
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                // ListView.builder создает элемент списка
                // только когда он видим на экране
                child: ListView.builder(
                  itemCount: nomenclatureList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetNomenclaturePage(id: nomenclatureList[index].getIdNomenclature!)));
                      },
                      child: ItemNomenclatureWidget(nomenclatureList[index]),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
  }
  }
}


