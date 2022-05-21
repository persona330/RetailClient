import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

import '../../model/Organization.dart';

class ItemOrganizationPage extends StatelessWidget
{
  final Organization organization;

  ItemOrganizationPage(this.organization);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
          leading: Text("${organization.getIdOrganization}"),
          title: Text('${organization.getName}'),
          subtitle: Text(
          'Тело:}\n'
          ),
          trailing: Text('${organization.getIdOrganization}'),
      ),
    );
  }
}