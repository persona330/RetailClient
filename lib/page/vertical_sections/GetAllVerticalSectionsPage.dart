import 'package:flutter/material.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/controller/PostController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/model/Post.dart';
import 'package:retail/page/address/CreateAddressPage.dart';
import 'package:retail/page/address/ItemAddressPage.dart';
import 'package:retail/page/address/GetAddressPage.dart';
import 'package:retail/service/AddressService.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/service/PostService.dart';

import '../../controller/VerticalSectionsController.dart';
import '../../model/VerticalSections.dart';
import 'GetVerticalSectionsPage.dart';
import 'ItemVerticalSectionsPage.dart';

// StatefulWidget - для изменяемых виджетов
class GetAllVerticalSectionsPage extends StatefulWidget
{
  const GetAllVerticalSectionsPage({Key? key}) : super(key: key);

  //final String title;

  @override
  _GetAllVerticalSectionsPageState createState() => _GetAllVerticalSectionsPageState();
}

// Домашняя страница
class _GetAllVerticalSectionsPageState extends StateMVC
{
  late VerticalSectionsController _controller;

  _GetAllVerticalSectionsPageState() : super(VerticalSectionsController()) {_controller = controller as VerticalSectionsController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getVerticalSectionsList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text("Вертикальные секции"),
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
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAddressPage())); },
        tooltip: 'Добавить вертикальную секцию',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
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
      // отображаем список постов
      final _verticalSectionsList = (state as VerticalSectionsGetListResultSuccess).verticalSectionsList;
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
                  itemCount: _verticalSectionsList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetVerticalSectionsPage(id: _verticalSectionsList[index].getIdVerticalSections!)));
                      },
                      child: ItemVerticalSectionsPage(_verticalSectionsList[index]),
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


