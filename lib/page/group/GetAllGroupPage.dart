import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/GroupController.dart';
import '../../model/Group.dart';
import 'CreateGroupPage.dart';
import 'GetGroupPage.dart';
import 'widget/ItemGroupWidget.dart';

class GetAllGroupPage extends StatefulWidget
{
  const GetAllGroupPage({Key? key}) : super(key: key);

  @override
  _GetAllGroupPageState createState() => _GetAllGroupPageState();
}

// Домашняя страница
class _GetAllGroupPageState extends StateMVC
{
  late GroupController _controller;

  _GetAllGroupPageState() : super(GroupController()) {_controller = controller as GroupController;}

  Widget appBarTitle = const Text("Группы");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  @override
  void initState()
  {
    super.initState();
    _controller.getGroupList();
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
                appBarTitle = const Text("Группы");
              }
            });
          } ,),]
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
                  itemCount: groupList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет

                    if (index != 0) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  GetGroupPage(
                                      id: groupList[index].getIdGroup!)));
                        },
                        child: ItemGroupWidget(groupList[index]),
                      );
                    }
                    else{ return const Text("");}
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


