import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/GroupController.dart';
import '../../model/Group.dart';

class PutGroupPage extends StatefulWidget
{
  final int id;
  const PutGroupPage({Key? key, required this.id}) : super(key: key);

  @override
  PutGroupPageState createState() => PutGroupPageState(id);

  static PutGroupPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutGroupPageState? result =
    context.findAncestorStateOfType<PutGroupPageState>();
    return result;
  }
}

class PutGroupPageState extends StateMVC
{
  GroupController? _controller;
  final int _id;

  PutGroupPageState(this._id) : super(GroupController()) {_controller = controller as GroupController;}

  final _nameController = TextEditingController();
  late Group _type;

  Group getType() {return _type;}
  void setType(Group type){ _type = type; }

  @override
  void initState()
  {
    super.initState();
    _controller?.getGroup(_id);
  }

  @override
  void dispose()
  {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is GroupResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is GroupResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _group = (state as GroupGetItemResultSuccess).group;
      _nameController.text = _group.getName!;
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение группы')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                    decoration: const InputDecoration(labelText: "Название"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      //_controller?.putAddress(_address1, _id);
                      Navigator.pop(context, true);
                      if (state is GroupAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Группа изменена")));}
                      if (state is GroupResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is GroupResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                    },
                    child: const Text('Изменить'),
                  ),
                ]
            ),
          ),
        ),
      );
    }
  }

}