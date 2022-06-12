import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/store/PutStorePage.dart';

import '../../../controller/OrganizationController.dart';
import '../../../model/Organization.dart';

class PutListOrganizationWidget extends StatefulWidget
{
  const PutListOrganizationWidget({Key? key}) : super(key: key);

  @override
  _PutListOrganizationWidgetState createState() => _PutListOrganizationWidgetState();
}

class _PutListOrganizationWidgetState extends StateMVC
{
  late OrganizationController _controller;
  late Organization _organization;

  _PutListOrganizationWidgetState() : super(OrganizationController()) {_controller = controller as OrganizationController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getOrganizationList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is OrganizationResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is OrganizationResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _organizationList = (state as OrganizationGetListResultSuccess).organizationList;
      _organization = _organizationList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Организация",),
          items: _organizationList.map((Organization items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Organization? item) {
            setState(() {
              _organization = item!;
            });
            PutStorePage.of(context)?.setOrganization(_organization);
          }
      );
  }
  }

}