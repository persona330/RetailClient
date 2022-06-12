import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/stillage/widget/PutListAreaWidget.dart';
import '../../controller/StillageController.dart';
import '../../model/Area.dart';
import '../../model/Stillage.dart';

class PutStillagePage extends StatefulWidget
{
  final int id;
  const PutStillagePage({Key? key, required this.id}) : super(key: key);

  @override
  PutStillagePageState createState() => PutStillagePageState(id);

  static PutStillagePageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutStillagePageState? result =
    context.findAncestorStateOfType<PutStillagePageState>();
    return result;
  }
}

class PutStillagePageState extends StateMVC
{
  StillageController? _controller;
  final int _id;

  PutStillagePageState(this._id) : super(StillageController()) {_controller = controller as StillageController;}

  final _numberController = TextEditingController();
  final _sizeController = TextEditingController();
  late Area _area;

  Area getArea(){return _area;}
  void setArea(Area area){ _area = area;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getStillage(_id);
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
    if (state is StillageResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is StillageResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _stillage = (state as StillageGetItemResultSuccess).stillage;
      _numberController.text = _stillage.getNumber!;
      _sizeController.text = _stillage.getSize!.toString();
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение стеллажа')),
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
                    decoration: const InputDecoration(labelText: "Вместимость"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _sizeController,
                    textInputAction: TextInputAction.next,
                  ),
                  const Flexible(
                    flex: 1,
                    child: PutListAreaWidget(),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Stillage _stillage1 = Stillage(idStillage: _id, number: _numberController.text, size: double.parse(_sizeController.text), area: getArea());
                      _controller?.putStillage(_stillage1, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is StillagePutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Стеллаж изменен")));}
                      if (state is StillageResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is StillageResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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