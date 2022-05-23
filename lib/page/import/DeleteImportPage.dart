import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

class DeleteImportPage extends StatelessWidget
{
  int id = 0;

  DeleteImportPage(this.id);

  Widget build(BuildContext context)
  {
    return CupertinoAlertDialog(
      title: Text("Удалить?"),
      content: Text("Данный привоз будет удален безвозвратно"),
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