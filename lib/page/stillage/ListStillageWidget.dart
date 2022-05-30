import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/organization/CreateOrganizationPage.dart';
import 'package:retail/page/shelf/CreateShelfPage.dart';
import 'package:retail/page/vertical_sections/CreateVerticalSectionsPage.dart';

import '../../controller/StillageController.dart';
import '../../model/Stillage.dart';

class ListStillageWidget extends StatefulWidget
{
  const ListStillageWidget({Key? key}) : super(key: key);

  @override
  _ListStillageWidgetState createState() => _ListStillageWidgetState();
}

class _ListStillageWidgetState extends StateMVC
{
  late StillageController _controller;
  late Stillage _stillage;

  _ListStillageWidgetState() : super(StillageController()) {_controller = controller as StillageController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getStillageList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is StillageResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StillageResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _stillageList = (state as StillageGetListResultSuccess).stillageList;
      _stillage = _stillageList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Стеллаж",),
          items: _stillageList.map((Stillage items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Stillage? item) {
            setState(() {
              _stillage = item!;
            });
            CreateVerticalSectionsPage.of(context)?.setStillage(_stillage);
            CreateShelfPage.of(context)?.setStillage(_stillage);
          }
      );
  }
  }

}