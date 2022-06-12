import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/stillage/widget/CreateListAreaWidget.dart';
import '../../controller/StillageController.dart';
import '../../model/Area.dart';
import '../../model/Stillage.dart';

class CreateStillagePage extends StatefulWidget
{
  const CreateStillagePage({Key? key}) : super(key: key);

  @override
  _CreateStillagePageState createState() => _CreateStillagePageState();

  static _CreateStillagePageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateStillagePageState? result =
    context.findAncestorStateOfType<_CreateStillagePageState>();
    return result;
  }
}

class _CreateStillagePageState extends StateMVC
{
  StillageController? _controller;

  _CreateStillagePageState() : super(StillageController()) {_controller = controller as StillageController;}

  final _numberController = TextEditingController();
  final _sizeController = TextEditingController();

  late Area _area;

  Area getArea(){return _area;}
  void setArea(Area area){ _area = area;}

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
      appBar: AppBar(title: const Text('Создание сттелажа')),
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
                  child: CreateListAreaWidget(),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Stillage _stillage = Stillage(idStillage: UniqueKey().hashCode, number: _numberController.text, size: double.parse(_sizeController.text), area: getArea());
                    _controller?.addStillage(_stillage);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is StillageAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Стеллаж создан")));}
                    if (state is StillageResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is StillageResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Создать'),
                ),
              ],
            ),
          ),
      ),
    );
  }
}