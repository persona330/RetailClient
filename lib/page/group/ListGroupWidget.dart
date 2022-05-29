import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/model/Group.dart';
import 'package:retail/page/organization/CreateOrganizationPage.dart';

import '../../controller/GroupController.dart';
import 'CreateGroupPage.dart';

class ListGroupWidget extends StatefulWidget
{
  ListGroupWidget({Key? key}) : super(key: key);

  @override
  _ListGroupWidgetState createState() => _ListGroupWidgetState();
}

class _ListGroupWidgetState extends StateMVC
{
  late GroupController _controller;
  late Group _group;

  _ListGroupWidgetState() : super(GroupController()) {_controller = controller as GroupController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getGroupList();
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller.currentState;
    if (state is GroupResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is GroupResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _groupList = (state as GroupGetListResultSuccess).groupList;
      _group = _groupList[0];

      return DropdownButtonFormField(
          isExpanded: true,
          decoration: InputDecoration(labelText: "Адрес",),
          items: _groupList.map((Group items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Group? item) {
            setState(() {
              _group = item!;
            });
            CreateGroupPage.of(context)?.setType(_group);
          }
      );
  }
  }

}