import 'package:flutter/cupertino.dart';

class DeleteVerticalSectionsPage extends StatelessWidget
{
  int id = 0;

  DeleteVerticalSectionsPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return CupertinoAlertDialog(
      title: const Text("Удалить?"),
      content: const Text("Данная вертикальная секция будет удалена безвозвратно"),
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