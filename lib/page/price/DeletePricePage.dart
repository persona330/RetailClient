import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeletePricePage extends StatelessWidget
{
  int id = 0;

  DeletePricePage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return CupertinoAlertDialog(
      title: const Text("Удалить?"),
      content: const Text("Данная цена будет удалена безвозвратно"),
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