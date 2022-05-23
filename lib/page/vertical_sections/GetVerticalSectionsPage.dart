import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/test/CreatePostPage.dart';
import 'package:retail/page/SearchAddressPage.dart';
import 'package:retail/page/address/PutAddressPage.dart';

import '../../controller/VerticalSectionsController.dart';
import '../../model/VerticalSections.dart';
import 'DeleteVerticalSectionsPage.dart';

class GetVerticalSectionsPage extends StatefulWidget
{
  final int id;
  const GetVerticalSectionsPage({Key? key, required this.id}) : super(key: key);


  @override
  GetVerticalSectionsPageState createState() => GetVerticalSectionsPageState(id);
}

class GetVerticalSectionsPageState extends StateMVC
{
  VerticalSectionsController? _controller;
  final int _id;

  GetVerticalSectionsPageState(this._id) : super(VerticalSectionsController()) {_controller = controller as VerticalSectionsController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getVerticalSections(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutAddressPage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeleteVerticalSectionsPage(_id)));
        if (value == true)
        {
          _controller?.deleteVerticalSections(_id);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Удалена")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is VerticalSectionsResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is VerticalSectionsResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _verticalSections = (state as VerticalSectionsGetItemResultSuccess).verticalSections;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о вертикальной секции №${_id}"),
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
                  Text("Номер: ${_verticalSections.getNumber} \n"
                      "Вместимость: ${_verticalSections.getSize} \n"
                      "Стеллаж: ${_verticalSections.getStillage.toString()}"
                      , style: TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}