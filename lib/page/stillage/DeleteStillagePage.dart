import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteStillagePage extends StatelessWidget
{
  int id = 0;

  DeleteStillagePage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return CupertinoAlertDialog(
      title: const Text("Удалить?"),
      content: const Text("Данный стеллаж будет удален безвозвратно"),
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