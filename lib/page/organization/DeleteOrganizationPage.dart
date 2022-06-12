import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteOrganizationPage extends StatelessWidget
{
  int id = 0;

  DeleteOrganizationPage(this.id, {Key? key}) : super(key: key);

  Widget build(BuildContext context)
  {
    return CupertinoAlertDialog(
      title: const Text("Удалить?"),
      content: const Text("Данная организация будет удалена безвозвратно"),
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