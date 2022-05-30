import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Shelf.dart';
import 'package:retail/model/VerticalSections.dart';
import 'package:retail/page/shelf/ListShelfWidget.dart';
import 'package:retail/page/vertical_sections/ListVerticalSectionsWidget.dart';
import '../../controller/BoxController.dart';
import '../../model/Box.dart';

class CreateBoxPage extends StatefulWidget
{
  const CreateBoxPage({Key? key}) : super(key: key);

  @override
  _CreateBoxPageState createState() => _CreateBoxPageState();

  static _CreateBoxPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateBoxPageState? result =
    context.findAncestorStateOfType<_CreateBoxPageState>();
    return result;
  }
}

class _CreateBoxPageState extends StateMVC
{
  BoxController? _controller;

  _CreateBoxPageState() : super(BoxController()) {_controller = controller as BoxController;}

  final _numberController = TextEditingController();
  final _sizeController = TextEditingController();

  late Shelf _shelf;
  late VerticalSections _verticalSections;

  Shelf getShelf(){return _shelf;}
  void setShelf(Shelf shelf){_shelf = shelf;}

  VerticalSections getVerticalSections(){return _verticalSections;}
  void setVerticalSections(VerticalSections verticalSections){ _verticalSections = verticalSections; }

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
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      appBar: AppBar(title: const Text('Создание ячейки')),
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
                  decoration: const InputDecoration(labelText: "Вместимость"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _sizeController,
                  textInputAction: TextInputAction.next,
                ),
                const Flexible(
                  flex: 1,
                  child: ListShelfWidget(),
                ),
                const Flexible(
                    flex: 2,
                    child: ListVerticalSectionsWidget()
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Box _box = Box(idBox: UniqueKey().hashCode, number: _numberController.text, size: double.parse(_sizeController.text), shelf: getShelf(), verticalSections: getVerticalSections());
                    _controller?.addBox(_box);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is BoxAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Добавлен")));}
                    if (state is BoxResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is BoxResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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