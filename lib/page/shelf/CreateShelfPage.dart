import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Group.dart';
import 'package:retail/model/Stillage.dart';
import 'package:retail/page/stillage/ListStillageWidget.dart';
import '../../controller/ShelfController.dart';
import '../../model/Shelf.dart';

class CreateShelfPage extends StatefulWidget
{
  const CreateShelfPage({Key? key}) : super(key: key);

  @override
  _CreateShelfPageState createState() => _CreateShelfPageState();

  static _CreateShelfPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateShelfPageState? result =
    context.findAncestorStateOfType<_CreateShelfPageState>();
    return result;
  }
}

class _CreateShelfPageState extends StateMVC
{
  ShelfController? _controller;

  _CreateShelfPageState() : super(ShelfController()) {_controller = controller as ShelfController;}

  final _numberController = TextEditingController();
  final _sizeController = TextEditingController();

  late Group _group;
  late Stillage _stillage;

  Group getGroup(){return _group;}
  void setGroup(Group group){_group = group;}

  Stillage getStillage(){return _stillage;}
  void setStillage(Stillage stillage){_stillage = stillage;}

  @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    _numberController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text('Создание полки')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Номер"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _numberController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Объем"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _sizeController,
                  textInputAction: TextInputAction.next,
                ),
                /*const Flexible(
                  flex: 1,
                  child: ListGroupWidget(),
                ),*/
                const Flexible(
                    flex: 2,
                    child: ListStillageWidget()
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Shelf _shelf = Shelf(idShelf: UniqueKey().hashCode, size: double.parse(_sizeController.text), number: _numberController.text, group: getGroup(), stillage: getStillage());
                    _controller?.addShelf(_shelf);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is ShelfAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Добавлен")));}
                    if (state is ShelfResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is ShelfResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Отправить'),
                ),
              ],
            ),
          ),
      ),
    );
  }
}