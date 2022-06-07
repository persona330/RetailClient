import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/box/widget/PutListShelfWidget.dart';
import 'package:retail/page/box/widget/PutListVerticalSectionsWidget.dart';
import '../../controller/BoxController.dart';
import '../../model/Box.dart';
import '../../model/Shelf.dart';
import '../../model/VerticalSections.dart';

class PutBoxPage extends StatefulWidget
{
  final int id;
  const PutBoxPage({Key? key, required this.id}) : super(key: key);

  @override
  PutBoxPageState createState() => PutBoxPageState(id);

  static PutBoxPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutBoxPageState? result =
    context.findAncestorStateOfType<PutBoxPageState>();
    return result;
  }
}

class PutBoxPageState extends StateMVC
{
  BoxController? _controller;
  final int _id;

  PutBoxPageState(this._id) : super(BoxController()) {_controller = controller as BoxController;}

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
    _controller?.getBox(_id);
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
    if (state is BoxResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is BoxResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _box = (state as BoxGetItemResultSuccess).box;
      _numberController.text = _box.getNumber!;
      _sizeController.text = _box.getSize!.toString();
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение ячейки')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Zа-яА-Я0-9]")),
                    ],
                    decoration: const InputDecoration(
                        labelText: "Номер"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _numberController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        labelText: "Вместимость"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _sizeController,
                    textInputAction: TextInputAction.next,
                  ),
                  const Flexible(
                    flex: 1,
                    child: PutListShelfWidget(),
                  ),
                  const Flexible(
                      flex: 2,
                      child: PutListVerticalSectionsWidget()
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Box _box = Box(idBox: _id, number: _numberController.text, size: double.parse(_sizeController.text), shelf: getShelf(), verticalSections: getVerticalSections());
                      _controller?.putBox(_box, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is BoxPutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ячейка изменена")));}
                      if (state is BoxResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is BoxResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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