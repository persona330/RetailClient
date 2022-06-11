import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/group/widget/CreateListGroupWidget.dart';
import '../../controller/GroupController.dart';
import '../../model/Group.dart';

class CreateGroupPage extends StatefulWidget
{
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();

  static _CreateGroupPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateGroupPageState? result =
    context.findAncestorStateOfType<_CreateGroupPageState>();
    return result;
  }
}

class _CreateGroupPageState extends StateMVC
{
  GroupController? _controller;

  _CreateGroupPageState() : super(GroupController()) {_controller = controller as GroupController;}

  final _nameController = TextEditingController();
  late Group _type;

  Group getType() {return _type;}
  void setType(Group type){ _type = type; }

    @override
  void initState()
  {
    super.initState();
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
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      appBar: AppBar(title: const Text('Создание группы')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Название"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                ),
                const Flexible(
                  flex: 1,
                  child: CreateListGroupWidget(),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Group _group = Group(idGroup: UniqueKey().hashCode, name: _nameController.text, type: getType());
                    _controller?.addGroup(_group);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is GroupAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Группа добавлена")));}
                    if (state is GroupResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is GroupResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Создание'),
                ),
              ],
            ),
          ),
      ),
    );
  }
}