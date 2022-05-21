import 'package:flutter/material.dart';
import 'package:retail/page/address/GetAddressPage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/service/PostService.dart';

import '../../controller/GroupController.dart';
import '../../model/Group.dart';
import 'CreateGroupPage.dart';
import 'ItemGroupPage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllGroupPage extends StatefulWidget
{
  const GetAllGroupPage({Key? key}) : super(key: key);

  //final String title;

  @override
  _GetAllGroupPageState createState() => _GetAllGroupPageState();
}

// Домашняя страница
class _GetAllGroupPageState extends StateMVC
{
  late GroupController _controller;

  _GetAllGroupPageState() : super(GroupController()) {_controller = controller as GroupController;}

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
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Группы товаров"),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
                onPressed: () => {
                  print("Click on settings button")
                }
                ),
        ],
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroupPage())); },
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
      return Column(
        children: [
          Expanded(
            child:
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                // ListView.builder создает элемент списка
                // только когда он видим на экране
                child: ListView.builder(
                  itemCount: groupList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetAddressPage(id: groupList[index].getIdGroup!)));
                      },
                      child: ItemGroupPage(groupList[index]),
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


