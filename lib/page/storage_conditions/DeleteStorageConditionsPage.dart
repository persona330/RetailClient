import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteStorageConditionsPage extends StatelessWidget
{
  int id = 0;

  DeleteStorageConditionsPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return CupertinoAlertDialog(
      title: const Text("Удалить?"),
      content: const Text("Данные условия хранения будут удалены безвозвратно"),
      actions: [
        CupertinoDialogAction(
            child: const Text("Да"),
            onPressed: ()
            {
              Navigator.of(context).pop(true);
            }
        ),
        CupertinoDialogAction(
            child: const Text("Нет"),
            onPressed: (){
              Navigator.of(context).pop(false);
            }
        )
      ],
    );
  }
}