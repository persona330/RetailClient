import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/OrganizationController.dart';
import '../../model/Organization.dart';
import 'DeleteOrganizationPage.dart';
import 'PutOrganizationPage.dart';

class GetOrganizationPage extends StatefulWidget
{
  final int id;
  const GetOrganizationPage({Key? key, required this.id}) : super(key: key);


  @override
  GetOrganizationPageState createState() => GetOrganizationPageState(id);
}

class GetOrganizationPageState extends StateMVC
{
  OrganizationController? _controller;
  final int _id;

  GetOrganizationPageState(this._id) : super(OrganizationController()) {_controller = controller as OrganizationController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getOrganization(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutOrganizationPage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeleteOrganizationPage(_id)));
        if (value == true)
        {
          _controller?.deleteOrganization(_id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Удалена")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
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
      final _organization = (state as OrganizationGetItemResultSuccess).organization;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация об организации №$_id"),
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
                  Text("Наименование: ${_organization.getName} \n"
                      "Номер ИНН: ${_organization.getInn} \n"
                      "Номер КПП: ${_organization.getKpp} \n"
                      "Адрес: ${_organization.getAddress.toString()} \n"
                      "Средство связи: ${_organization.getCommunication.toString()} \n"
                      , style: const TextStyle(fontSize: 22)),

                ],
              ),
            ),
          ),
      );
    }
  }
}