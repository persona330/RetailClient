import 'package:flutter/material.dart';
import 'package:retail/page/organization/CreateOrganizationPage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/OrganizationController.dart';
import '../../model/Organization.dart';
import 'GetOrganizationPage.dart';
import 'widget/ItemOrganizationWidget.dart';

class GetAllOrganizationPage extends StatefulWidget
{
  const GetAllOrganizationPage({Key? key}) : super(key: key);

  @override
  _GetAllOrganizationPageState createState() => _GetAllOrganizationPageState();

  static _GetAllOrganizationPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _GetAllOrganizationPageState? result =
    context.findAncestorStateOfType<_GetAllOrganizationPageState>();
    return result;
  }
}

class _GetAllOrganizationPageState extends StateMVC
{
  late OrganizationController _controller;

  _GetAllOrganizationPageState() : super(OrganizationController()) {_controller = controller as OrganizationController;}

  Widget appBarTitle = const Text("Организации");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  refresh() {
    setState(() {});
  }

  @override
  void initState()
  {
    super.initState();
    _controller.getOrganizationList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        leading:  IconButton(icon: const Icon(Icons.arrow_back),
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
                appBarTitle = const Text("Организации");
              }
            });
          } ,),]
      ),
      // body - задает основное содержимое
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateOrganizationPage())); },
        tooltip: 'Добавить организацию',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is OrganizationResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is OrganizationResultFailure)
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
      final organizationList = (state as OrganizationGetListResultSuccess).organizationList;
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
                  itemCount: organizationList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetOrganizationPage(id: organizationList[index].getIdOrganization!)));
                      },
                      child: ItemOrganizationWidget(organizationList[index]),
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


