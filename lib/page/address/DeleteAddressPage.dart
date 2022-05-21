import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

class DeleteAddressPage extends StatelessWidget
{
  int id = 0;

  DeleteAddressPage(this.id);

  Widget build(BuildContext context)
  {
    return CupertinoAlertDialog(
      title: Text("Удалить?"),
      content: Text("Данный адрес будет удален безвозвратно"),
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