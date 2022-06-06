import 'package:flutter/material.dart';
import 'package:retail/page/address/CreateAddressPage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/VerticalSectionsController.dart';
import '../../model/VerticalSections.dart';
import 'GetVerticalSectionsPage.dart';
import 'widget/ItemVerticalSectionsWidget.dart';

class GetAllVerticalSectionsPage extends StatefulWidget
{
  const GetAllVerticalSectionsPage({Key? key}) : super(key: key);

  @override
  _GetAllVerticalSectionsPageState createState() => _GetAllVerticalSectionsPageState();
}

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
      appBar: AppBar(
        title: const Text("Вертикальные секции"),
        leading: IconButton(icon:const Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.settings),
                onPressed: () => {
                  print("Click on settings button")
                }
                ),
        ],
      ),
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
      final _verticalSectionsList = (state as VerticalSectionsGetListResultSuccess).verticalSectionsList;
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
                  itemCount: _verticalSectionsList.length,
                  itemBuilder: (context, index) {
                    // мы вынесли элемент списка в
                    // отдельный виджет
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetVerticalSectionsPage(id: _verticalSectionsList[index].getIdVerticalSections!)));
                      },
                      child: ItemVerticalSectionsWidget(_verticalSectionsList[index]),
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


