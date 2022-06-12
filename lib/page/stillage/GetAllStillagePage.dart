import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/StillageController.dart';
import '../../model/Stillage.dart';
import 'CreateStillagePage.dart';
import 'GetStillagePage.dart';
import 'widget/ItemStillageWidget.dart';

class GetAllStillagePage extends StatefulWidget
{
  const GetAllStillagePage({Key? key}) : super(key: key);

  @override
  _GetAllStillagePageState createState() => _GetAllStillagePageState();
}

class _GetAllStillagePageState extends StateMVC
{
  late StillageController _controller;

  _GetAllStillagePageState() : super(StillageController()) {_controller = controller as StillageController;}

  Widget appBarTitle = const Text("Стеллаж");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  @override
  void initState()
  {
    super.initState();
    _controller.getStillageList();
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
                appBarTitle = const Text("Стеллаж");
              }
            });
          } ,),]
      ),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateStillagePage())); },
        tooltip: 'Добавить стеллаж',
        child: const Icon(Icons.add),
      ),
    );
  }
  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is StillageResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StillageResultFailure)
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
      final _stillageList = (state as StillageGetListResultSuccess).stillageList;
      return Column(
        children: [
          Expanded(
            child:
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: _stillageList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetStillagePage(id: _stillageList[index].getIdStillage!)));
                      },
                      child: ItemStillageWidget(_stillageList[index]),
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


