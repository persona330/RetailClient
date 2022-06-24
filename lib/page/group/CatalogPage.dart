import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/group/widget/ProductListViewWidget.dart';
import '../../controller/GroupController.dart';
import '../../model/Group.dart';
import '../nomenclature/CreateNomenclaturePage.dart';
import 'CreateGroupPage.dart';
import 'widget/ItemGroupWidget.dart';

class CatalogPage extends StatefulWidget
{
  final Group group;
  const CatalogPage({Key? key, required this.group}) : super(key: key);

  @override
  _CatalogPageState createState() => _CatalogPageState(group);
}

// Домашняя страница
class _CatalogPageState extends StateMVC
{
  late GroupController _controller;
  late Group _group;

  _CatalogPageState(this._group) : super(GroupController()) {_controller = controller as GroupController;}

  Widget appBarTitle = const Text("Группы");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  Group getGroup(){return _group;}
  void setGroup(Group group){_group = group;}

  @override
  void initState()
  {
    super.initState();
    appBarTitle = Text("${_group.getName}");
    _controller.getGroupList();
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Добавить товар':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateNomenclaturePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
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
                  appBarTitle = const Text("Группа");
                }
              });
            } ,),
            PopupMenuButton<String>(
              onSelected: _handleClick, // функция при нажатии
              itemBuilder: (BuildContext context)
              {
                return {'Добавить товар'}.map((String choice)
                {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ]

      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateGroupPage())); setState(() {});},
        tooltip: 'Добавить группу товара',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is GroupResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is GroupResultFailure)
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
      final groupList = (state as GroupGetListResultSuccess).groupList;
      appBarTitle = Text(groupList[0].getName!);
      List<Group> list = [];
      for(var idx in groupList)
      {
        if (idx.getType?.getIdGroup == _group.getIdGroup)
        {
          list.add(idx);
        }
      }
      return Column(
        children: [
          Expanded(
            child:
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                // ListView.builder создает элемент списка
                // только когда он видим на экране
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setGroup(list[index]);
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => CatalogPage(group: list[index])));
                        },
                        child: ItemGroupWidget(list[index]),
                      );
                  },
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: NomenclatureListViewWidget(group: _group),
              ),
          ),
        ],
      );
    }
  }
}


