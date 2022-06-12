import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../controller/OrganizationController.dart';
import '../../../model/Organization.dart';
import '../CreateSupplierPage.dart';

class CreateListOrganizationWidget extends StatefulWidget
{
  const CreateListOrganizationWidget({Key? key}) : super(key: key);

  @override
  _CreateListOrganizationWidgetState createState() => _CreateListOrganizationWidgetState();
}

class _CreateListOrganizationWidgetState extends StateMVC
{
  late OrganizationController _controller;
  late Organization _organization;

  _CreateListOrganizationWidgetState() : super(OrganizationController()) {_controller = controller as OrganizationController;}

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
            CreateSupplierPage.of(context)?.setOrganization(_organization);
          }
      );
  }
  }

}