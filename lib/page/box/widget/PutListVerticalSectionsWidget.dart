import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../controller/VerticalSectionsController.dart';
import '../../../model/VerticalSections.dart';
import '../PutBoxPage.dart';

class PutListVerticalSectionsWidget extends StatefulWidget
{
  const PutListVerticalSectionsWidget({Key? key}) : super(key: key);

  @override
  _PutListVerticalSectionsWidgetState createState() => _PutListVerticalSectionsWidgetState();
}

class _PutListVerticalSectionsWidgetState extends StateMVC
{
  late VerticalSectionsController _controller;
  late VerticalSections _verticalSections;

  _PutListVerticalSectionsWidgetState() : super(VerticalSectionsController()) {_controller = controller as VerticalSectionsController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getVerticalSectionsList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is VerticalSectionsResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is VerticalSectionsResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _verticalSectionsList = (state as VerticalSectionsGetListResultSuccess).verticalSectionsList;
      _verticalSections = _verticalSectionsList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Вертикальная секция",),
          items: _verticalSectionsList.map((VerticalSections items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (VerticalSections? item) {
            setState(() {
              _verticalSections = item!;
            });
            PutBoxPage.of(context)?.setVerticalSections(_verticalSections);
          }
      );
  }
  }

}