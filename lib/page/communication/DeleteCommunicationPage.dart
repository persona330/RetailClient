import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

class DeleteCommunicationPage extends StatelessWidget
{
  int id = 0;

  DeleteCommunicationPage(this.id);

  Widget build(BuildContext context)
  {
    return CupertinoAlertDialog(
      title: Text("Удалить?"),
      content: Text("Данное средство связи будет удалено безвозвратно"),
      actions: [
        CupertinoDialogAction(
            child: Text("Да"),
            onPressed: ()
            {
              Navigator.of(context).pop(true);
            }
        ),
        CupertinoDialogAction(
            child: Text("Нет"),
            onPressed: (){
              Navigator.of(context).pop(false);
            }
        )
      ],
    );
  }
}