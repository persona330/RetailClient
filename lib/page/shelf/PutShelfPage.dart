import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/shelf/widget/PutListStillageWidget.dart';
import '../../controller/ShelfController.dart';
import '../../model/Group.dart';
import '../../model/Shelf.dart';
import '../../model/Stillage.dart';
import '../group/widget/PutListGroupWidget.dart';

class PutShelfPage extends StatefulWidget
{
  final int id;
  const PutShelfPage({Key? key, required this.id}) : super(key: key);

  @override
  PutShelfPageState createState() => PutShelfPageState(id);

  static PutShelfPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutShelfPageState? result =
    context.findAncestorStateOfType<PutShelfPageState>();
    return result;
  }}

class PutShelfPageState extends StateMVC
{
  ShelfController? _controller;
  final int _id;

  PutShelfPageState(this._id) : super(ShelfController()) {_controller = controller as ShelfController;}

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
    _controller?.getShelf(_id);
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
    final state = _controller?.currentState;
    if (state is ShelfResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ShelfResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _shelf = (state as ShelfGetItemResultSuccess).shelf;
      _numberController.text = _shelf.getNumber!;
      _sizeController.text = _shelf.getSize!.toString();
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение полки')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
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
                  const Flexible(
                    flex: 1,
                    child: PutListGroupWidget(),
                  ),
                  const Flexible(
                      flex: 2,
                      child: PutListStillageWidget()
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: ()
                    {
                      Shelf _shelf1 = Shelf(idShelf: _id, size: double.parse(_sizeController.text), number: _numberController.text, group: getGroup(), stillage: getStillage());
                      _controller?.putShelf(_shelf1, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is ShelfAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Полка изменена")));}
                      if (state is ShelfResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is ShelfResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}

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