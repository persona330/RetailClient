import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/vertical_sections/widget/PutListStillageWidget.dart';
import '../../controller/VerticalSectionsController.dart';
import '../../model/Stillage.dart';
import '../../model/VerticalSections.dart';

class PutVerticalSectionsPage extends StatefulWidget
{
  final int id;
  const PutVerticalSectionsPage({Key? key, required this.id}) : super(key: key);

  @override
  PutVerticalSectionsPageState createState() => PutVerticalSectionsPageState(id);

  static PutVerticalSectionsPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutVerticalSectionsPageState? result =
    context.findAncestorStateOfType<PutVerticalSectionsPageState>();
    return result;
  }
}

class PutVerticalSectionsPageState extends StateMVC
{
  VerticalSectionsController? _controller;
  final int _id;

  PutVerticalSectionsPageState(this._id) : super(VerticalSectionsController()) {_controller = controller as VerticalSectionsController;}

  final _numberController = TextEditingController();
  final _sizeController = TextEditingController();

  late Stillage _stillage;

  Stillage getStillage(){return _stillage;}
  void setStillage(Stillage stillage){_stillage = stillage;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getVerticalSections(_id);
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
    if (state is VerticalSectionsResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is VerticalSectionsResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _verticalSections = (state as VerticalSectionsGetItemResultSuccess).verticalSections;
      _numberController.text = _verticalSections.getNumber!;
      _sizeController.text = _verticalSections.getSize!.toString();
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение адреса')),
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
                    child: PutListStillageWidget(),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      VerticalSections _verticalSections = VerticalSections(idVerticalSections: _id, number: _numberController.text, size: double.parse(_sizeController.text), stillage: getStillage());
                      _controller?.putVerticalSections(_verticalSections, _id);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Вертикальная секция изменена")));
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is VerticalSectionsAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Добавлен")));}
                      if (state is VerticalSectionsResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is VerticalSectionsResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                    },
                    child: const Text('Отправить'),
                  ),
                ]
            ),
          ),
        ),
      );
    }
  }

}